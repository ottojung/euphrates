;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (make-lalr-lexer/singlechar-factory
         taken-token-names-set tokens-alist)

  (define chars-map (make-hashmap))

  (define (terminal->char t)
    (cond
     ((char? t) t)
     ((string? t)
      (let ()
        (define chars (string->list t))
        (unless (list-length= 1 chars)
          (raisu* :from "lalr-lexer/singlechar"
                  :type 'bad-string
                  :message "Singlechar lexer expected a string of length 1, but got a different length"
                  :args (list t)))

        (car chars)))

     (else
      (raisu* :from "lalr-lexer/singlechar"
              :type 'bad-terminal
              :message "Singlechar lexer expected a terminal of type string of char, but got some other type"
              :args (list t)))))

  (define safer-taken-names-list
    (let ((L (hashset->list taken-token-names-set)))
      (append (map car tokens-alist) L)
      L))

  (define (prefix-taken? prefix)
    (list-or-map
     (comp (string-prefix? prefix))
     safer-taken-names-list))

  (define terminal-prefix
    (let ()
      (define (make-prefix x)
        (cond
         ((equal? x 0) "t_")
         (else (string-append "t_" (~a x)))))

      (let loop ((index 0))
        (define prefix (make-prefix index))
        (if (prefix-taken? prefix)
            (loop (+ index 1))
            prefix))))

  (define (generate-new-name suffix)
    (string->symbol
     (string-append terminal-prefix (~a suffix))))

  (define classes
    (list 'any 'alphanum 'alphabetic 'upcase 'lowercase 'nocase 'numeric 'whitespace))

  (define class-expressions
    (map (lambda (c) (list 'class c)) classes))

  (for-each
   (fn-pair
    (key value)
    (unless (member value class-expressions)
      (hashmap-set!
       chars-map (terminal->char value) key)))
   tokens-alist)

  (define (is-nocase-alpha? c)
    (and (char-alphabetic? c)
         (not (char-upper-case? c))
         (not (char-lower-case? c))))

  (define (get-used-set predicate)
    (define (get-first-char s) (string-ref s 0)) ;; FIXME: assumes only strings
    (define char-only (filter (comp cdr string?) tokens-alist)) ;; FIXME: assumes only strings
    (map list (map car (filter (comp cdr get-first-char predicate) char-only))))

  (define upcase-used (get-used-set char-upper-case?))
  (define lowercase-used (get-used-set char-lower-case?))
  (define nocase-used (get-used-set is-nocase-alpha?))
  (define numeric-used (get-used-set char-numeric?))
  (define whitespace-used (get-used-set char-whitespace?))

  (define (get-class-bindings class)
    (define class-expr (list 'class class))
    (map car (filter (comp cdr (equal? class-expr)) tokens-alist)))

  (define (get-token-for-class name)
    (define found (get-class-bindings name))
    (cond
     ((null? found) (generate-new-name name))
     ((null? (cdr found)) (car found))
     (else
      (raisu* :from "lalr-lexer/singlechar"
              :type 'duplicated-token
              :message "Same set used for two different tokens"
              :args (list name found)))))

  (define any (get-token-for-class 'any))
  (define alphanum (get-token-for-class 'alphanum))
  (define alphabetic (get-token-for-class 'alphabetic))
  (define upcase (get-token-for-class 'upcase))
  (define lowercase (get-token-for-class 'lowercase))
  (define nocase (get-token-for-class 'nocase))
  (define numeric (get-token-for-class 'numeric))
  (define whitespace (get-token-for-class 'whitespace))

  (define (class-bindings-exist? class)
    (not (null? (get-class-bindings class))))

  (define (get-token-names class default-category)
    (if (class-bindings-exist? class)
        (let ()
          (define category
            (generate-new-name (~a class)))
          (define tokens (list (list category)))
          (values category tokens))
        (let ()
          (define category default-category)
          (define tokens '())
          (values category tokens))))

  (define most-default-category (generate-new-name 'default))

  (define-values (category-any tokens-any) (get-token-names 'any most-default-category))
  (define-values (category-alphanum tokens-alphanum) (get-token-names 'alphanum category-any))
  (define-values (category-alphabetic tokens-alphabetic) (get-token-names 'alphabetic category-alphanum))
  (define-values (category-upcase tokens-upcase) (get-token-names 'upcase category-alphabetic))
  (define-values (category-lowercase tokens-lowercase) (get-token-names 'lowercase category-alphabetic))
  (define-values (category-nocase tokens-nocase) (get-token-names 'nocase category-alphabetic))
  (define-values (category-numeric tokens-numeric) (get-token-names 'numeric category-alphanum))
  (define-values (category-whitespace tokens-whitespace) (get-token-names 'whitespace category-any))

  (define additional-grammar-rules
    `((,any (,alphanum) (,whitespace) ,@tokens-any)
      (,alphanum (,alphabetic) (,numeric))
      (,alphabetic (,upcase) (,lowercase) (,nocase))

      (,upcase ,@upcase-used ,@tokens-upcase)
      (,lowercase ,@lowercase-used ,@tokens-lowercase)
      (,nocase ,@nocase-used ,@tokens-nocase)

      (,numeric ,@numeric-used ,@tokens-numeric)

      (,whitespace ,@whitespace-used ,@tokens-whitespace)
      ))

  (define (factory input)
    (define offset 0)
    (define linenum 0)
    (define colnum 0)

    (define (adjust-positions! c)
      (set! offset (+ offset 1))

      (define nl? (equal? c #\newline))
      (when nl? (set! linenum (+ linenum 1)))
      (set! colnum (if nl? 0 (+ 1 colnum))))

    (define read-next-char
      (cond
       ((string? input)
        (let ((input-length (string-length input)))
          (lambda _
            (if (>= offset input-length)
                (eof-object)
                (let ((c (string-ref input offset)))
                  (adjust-positions! c)
                  c)))))
       ((port? input)
        (lambda _
          (let ((c (read-char input)))
            (unless (eof-object? c)
              (adjust-positions! c))
            c)))
       (else
        (raisu* :from "lalr-lexer/singlechar"
                :type 'bad-input
                :message "Singlechar lexer expected a string or a port as input, but got some other type"
                :args (list input)))))

    (define (wrap-return c category)
      (define location
        (make-source-location '*stdin* linenum colnum offset 1))
      (make-lexical-token category location c))

    (define (process-next . _)
      (define c (read-next-char))
      (if (eof-object? c) '*eoi*
          (let ()
            (define category
              (or (hashmap-ref chars-map c #f)
                  (and (char-whitespace? c) category-whitespace)
                  (and (char-numeric? c) category-numeric)
                  (and (is-nocase-alpha? c) category-nocase)
                  (and (char-lower-case? c) category-lowercase)
                  (and (char-upper-case? c) category-upcase)
                  category-any))

            (when (eq? category most-default-category)
              (raisu* :from "make-lalr-lexer/irregex-factory"
                      :type 'unrecognized-character
                      :message "Encountered a character that is not handled by any of the grammar rules"
                      :args (list c)))

            (wrap-return c category))))

    process-next)

  factory)
