;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (make-lalr-lexer/singlechar-factory tokens-alist default-token)
  (define chars-map (make-hashmap))

  (define (terminal->char t)
    (cond
     ((char? t) t)
     ((string? t)
      (let ()
        (define chars (string->list t))
        (unless (list-length= 1 chars)
          (raisu* :from "make-lalr-lexer/irregex-factory"
                  :type 'bad-string
                  :message "Singlechar lexer expected a string of length 1, but got a different length"
                  :args (list t)))

        (car chars)))
     (else
      (raisu* :from "make-lalr-lexer/irregex-factory"
              :type 'bad-terminal
              :message "Singlechar lexer expected a terminal of type string of char, but got some other type"
              :args (list t)))))

  (for-each
   (fn-pair
    (key value)
    (hashmap-set!
     chars-map (terminal->char value) key))
   tokens-alist)

  (lambda (input)
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
        (raisu* :from "make-lalr-lexer/irregex-factory"
                :type 'bad-input
                :message "Singlechar lexer expected a string or a port as input, but got some other type"
                :args (list input)))))

    (define (process-next . _)
      (define c (read-next-char))
      (if (eof-object? c) '*eoi*
          (let ()
            (define category
              (hashmap-ref chars-map c default-token))
            (define location
              (make-source-location '*stdin* linenum colnum offset 1))
            (make-lexical-token category location c))))

    process-next))
