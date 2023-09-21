;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (make-lalr-lexer/singlechar
         taken-token-names-set tokens-alist)

  (define classes
    (list 'any 'alphanum 'alphabetic 'upcase 'lowercase 'nocase 'numeric 'whitespace))

  (define class-expressions
    (map (lambda (c) (list 'class c)) classes))

  (define safer-taken-names-list
    (let ((L (hashset->list taken-token-names-set)))
      (map ~a (append (map car tokens-alist) L))))

  (define (prefix-taken? prefix)
    (list-or-map
     (comp (string-prefix? prefix))
     safer-taken-names-list))

  (define terminal-prefix
    (let ()
      (define (make-prefix x)
        (cond
         ((equal? x 0) "c_")
         (else (string-append "c" (~a x) "_"))))

      (let loop ((index 0))
        (define prefix (make-prefix index))
        (if (prefix-taken? prefix)
            (loop (+ index 1))
            prefix))))

  (define singleton-categories
    (make-hashmap))

  (define singleton-map ;; inverse of `singleton-categories'
    (make-hashmap))

  (define (add-singleton-category singleton category)
    (hashmap-set! singleton-map singleton category)
    (hashmap-set! singleton-categories category singleton)
    (when #f #t))

  (define (get-singleton-token c)
    (or (hashmap-ref singleton-map c #f)
        (let ()
          (define category (generate-new-name (string c)))
          (add-singleton-category c category)
          category)))

  (define (populate-singleton-categories p)
    (define-pair (category char) p)
    (add-singleton-category char category))

  (let ()
    (define singleton-tokens-alist
      (filter
       identity
       (map (lambda (p)
              (define-pair (token expr) p)
              (cond
               ((char? expr) p)

               ((and (string? expr)
                     (= 1 (string-length expr)))
                (cons token (string-ref expr 0)))

               ((string? expr) #f)

               ((and (pair? expr)
                     (equal? 'class (car expr)))

                (unless (list? expr)
                  (raisu* :from "lalr-lexer/singlechar"
                          :type 'bad-class-form
                          :message "Class definition in singlechar lexer must be a list, but was not"
                          :args (list expr)))

                (unless (list-length= 2 expr)
                  (raisu* :from "lalr-lexer/singlechar"
                          :type 'bad-class-form-length
                          :message "Class definition in singlechar lexer must have two components, but did not"
                          :args (list expr)))

                (unless (member (cadr expr) classes)
                  (raisu* :from "lalr-lexer/singlechar"
                          :type 'bad-class-name
                          :message (stringf "Bad class name used in singlechar, must be one of ~a"
                                            (words->string (map (compose ~s ~a) classes)))
                          :args (list (cadr expr))))

                #f)

               (else
                (raisu* :from "lalr-lexer/singlechar"
                        :type 'bad-token-type
                        :message (stringf "Unknown element of ~s in singlechar lexer" (~a (quote tokens-alist)))
                        :args (list expr)))))

            tokens-alist)))

    (for-each populate-singleton-categories singleton-tokens-alist))

  (define additional-grammar-rules/strings
    (filter
     identity
     (map (lambda (p)
            (define-pair (token expr) p)

            (and (string? expr)
                 (< 1 (string-length expr))
                 (cons token
                       (list (map get-singleton-token
                                  (string->list expr))))))
          tokens-alist)))

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

  (define (generate-new-name suffix)
    (string->symbol
     (string-append terminal-prefix (~a suffix))))

  (define singleton-tokens-alist
    (hashmap->alist singleton-map))

  (define (get-used-set predicate)
    (map list (map cdr (filter (comp car predicate) singleton-tokens-alist))))

  (define upcase-used (get-used-set char-upper-case?))
  (define lowercase-used (get-used-set char-lower-case?))
  (define nocase-used (get-used-set char-nocase-alphabetic?))
  (define numeric-used (get-used-set char-numeric?))
  (define whitespace-used (get-used-set char-whitespace?))

  (define (get-class-bindings class)
    (define class-expr (list 'class class))
    (map car (filter (comp cdr (equal? class-expr)) tokens-alist)))

  (define found-non-terminals
    (make-hashset))

  (define (get-token-for-class name)
    (define found (get-class-bindings name))
    (cond
     ((null? found) (generate-new-name name))
     ((null? (cdr found))
      (hashset-add! found-non-terminals (car found))
      (car found))
     (else
      (raisu* :from "lalr-lexer/singlechar"
              :type 'duplicated-token
              :message "Same set used for two different tokens"
              :args (list name found)))))

  (define nt-any (get-token-for-class 'any))
  (define nt-alphanum (get-token-for-class 'alphanum))
  (define nt-alphabetic (get-token-for-class 'alphabetic))
  (define nt-upcase (get-token-for-class 'upcase))
  (define nt-lowercase (get-token-for-class 'lowercase))
  (define nt-nocase (get-token-for-class 'nocase))
  (define nt-numeric (get-token-for-class 'numeric))
  (define nt-whitespace (get-token-for-class 'whitespace))

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

  (define additional-grammar-rules/singletons/initial
    `((,nt-any (,nt-alphanum) (,nt-whitespace) ,@tokens-any)
      (,nt-alphanum (,nt-alphabetic) (,nt-numeric) ,@tokens-alphanum)
      (,nt-alphabetic (,nt-upcase) (,nt-lowercase) (,nt-nocase) ,@tokens-alphabetic)

      (,nt-upcase ,@upcase-used ,@tokens-upcase)
      (,nt-lowercase ,@lowercase-used ,@tokens-lowercase)
      (,nt-nocase ,@nocase-used ,@tokens-nocase)

      (,nt-numeric ,@numeric-used ,@tokens-numeric)

      (,nt-whitespace ,@whitespace-used ,@tokens-whitespace)
      ))

  (define additional-grammar-rules/singletons/no-unused-classes
    (filter car additional-grammar-rules/singletons/initial))

  (define all-terminals
    (list-deduplicate/reverse
     (append
      (map car tokens-alist)
      (map cdr singleton-tokens-alist)
      (list category-any
            category-alphanum
            category-alphabetic
            category-upcase
            category-lowercase
            category-nocase
            category-numeric
            category-whitespace))))

  (define (remove-empty-terms grammar)
    (define no-singletons
      (filter (negate list-singleton?) grammar))

    (define all-nonterminals
      (map car no-singletons))

    (define all-nonterminals/s
      (list->hashset all-nonterminals))

    (define all-defined
      (list->hashset
       (append all-terminals all-nonterminals)))

    (define (inline-not-found-nonterminals alternation)
      (define (inline term)
        (if (hashset-has? all-nonterminals/s term)
            (if (hashset-has? found-non-terminals term)
                (list term)
                (apply append (assq-or term grammar '())))
            (list term)))
      (map inline alternation))

    (define (remove-undefined-expansion-terms alternation)
      (define (rem term)
        (if (hashset-has? all-defined term) (list term) '()))
      (apply append (map rem alternation)))

    (define no-undefined-references
      (map
       (lambda (production)
         (define nont (car production))
         (define alternations (cdr production))
         (define alternations/1
           (apply append (map inline-not-found-nonterminals alternations)))
         (define alternations/2
           (map remove-undefined-expansion-terms alternations/1))
         (define alternations/3
           (filter (negate null?) alternations/2))
         (cons nont alternations/3))
       no-singletons))

    no-undefined-references)

  (define additional-grammar-rules/singletons/1
    (apply-until-fixpoint
     remove-empty-terms
     additional-grammar-rules/singletons/no-unused-classes))

  (define additional-grammar-rules/singletons
    (filter (comp car (hashset-has? found-non-terminals))
            additional-grammar-rules/singletons/1))

  (define additional-grammar-rules
    (append additional-grammar-rules/singletons
            additional-grammar-rules/strings))

  (define categories
    `((whitespace . ,category-whitespace)
      (numeric . ,category-numeric)
      (nocase . ,category-nocase)
      (lowercase . ,category-lowercase)
      (upcase . ,category-upcase)
      (any . ,category-any)
      (most-default . ,most-default-category)))

  (make-lalr-lexer/singlechar-struct
   additional-grammar-rules
   categories singleton-map))
