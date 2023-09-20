;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (lalr-lexer/singlechar-start this input-type)

  (define singleton-map
    (lalr-lexer/singlechar-struct:singleton-map this))

  (define categories
    (lalr-lexer/singlechar-struct:categories this))

  (define category-whitespace
    (assq-or 'whitespace categories #f))
  (define category-numeric
    (assq-or 'numeric categories #f))
  (define category-nocase
    (assq-or 'nocase categories #f))
  (define category-lowercase
    (assq-or 'lowercase categories #f))
  (define category-upcase
    (assq-or 'upcase categories #f))
  (define category-any
    (assq-or 'any categories #f))
  (define most-default-category
    (assq-or 'most-default categories #f))

  (define (initializer input)

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
       ((equal? 'string input-type)

        (unless (string? input)
          (raisu* :from "lalr-lexer/singlechar"
                  :type 'bad-input-type
                  :message "Singlechar lexer expected a string, but got some other type"
                  :args (list input)))

        (let ((input-length (string-length input)))
          (lambda _
            (if (>= offset input-length)
                (eof-object)
                (let ((c (string-ref input offset)))
                  (adjust-positions! c)
                  c)))))

       ((equal? 'port input-type)

        (unless (port? input)
          (raisu* :from "lalr-lexer/singlechar"
                  :type 'bad-input-type
                  :message "Singlechar lexer expected a port, but got some other type"
                  :args (list input)))

        (lambda _
          (let ((c (read-char input)))
            (unless (eof-object? c)
              (adjust-positions! c))
            c)))

       (else
        (raisu* :from "lalr-lexer/singlechar"
                :type 'bad-input-type
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
              (or (hashmap-ref singleton-map c #f)
                  (and (char-whitespace? c) category-whitespace)
                  (and (char-numeric? c) category-numeric)
                  (and (char-nocase-alphabetic? c) category-nocase)
                  (and (char-lower-case? c) category-lowercase)
                  (and (char-upper-case? c) category-upcase)
                  category-any))

            (when (eq? category most-default-category)
              (raisu* :from "make-lalr-lexer/irregex-factory"
                      :type 'unrecognized-character
                      :message "Encountered a character that is not handled by any of the grammar rules"
                      :args (list c)))

            (wrap-return c category))))

    (make-lalr-lexer/singlechar-result-struct process-next))

  initializer)
