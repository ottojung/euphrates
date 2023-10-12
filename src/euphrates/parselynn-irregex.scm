;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (make-parselynn/irregex-factory tokens-alist)
  (define (terminal->regex t)
    (cond
     ((string? t)
      (sre->irregex `(seq bos ,t)))
     ((and (list? t) (pair? t))
      (sre->irregex `(seq bos ,@t)))
     (else
      (raisu* :from "make-parselynn/irregex-factory"
              :type 'bad-regex
              :message "Irregex lexer expected a string or a non empty list for the regex, but got something else"
              :args (list t)))))

  (define regex-alist
    (map
     (compose-under cons car (comp cdr terminal->regex))
     tokens-alist))

  (lambda (input-string)
    (define offset 0)
    (define linenum 0)
    (define colnum 0)
    (define input-length (string-length input-string))

    (unless (string? input-string)
      (raisu* :from "parselynn/irregex"
              :type 'bad-input-string-type
              :message "Lexer expected string as input, but got something else"
              :args (list input-string)))

    (define (adjust-positions! s)
      (set! offset (+ offset (string-length s)))

      (define (for-c c)
        (define nl? (equal? c #\newline))
        (when nl? (set! linenum (+ linenum 1)))
        (set! colnum (if nl? 0 (+ 1 colnum))))
      (string-for-each for-c s))

    (define (make-context-string)
      (substring input-string offset (min (+ offset 10) input-length)))

    (define (process-token-mapping p)
      (define-pair (token reg) p)
      (define m (irregex-search reg input-string offset))
      (and m (cons token (irregex-match-substring m))))

    (define (process-next)
      (define r
        (list-map-first
         process-token-mapping #f
         regex-alist))

      (unless r
        (raisu* :from 'parselynn/irregex
                :type 'lexer-error
                :message "Lexer encountered an unknown sequence of characters"
                :args (list offset (make-context-string))))

      (define-pair (token s) r)
      (adjust-positions! s)

      (let ((location (make-source-location '*stdin* linenum colnum offset (string-length s))))
        (make-lexical-token token location s)))

    (lambda _
      (if (>= offset input-length) '*eoi*
          (process-next)))))
