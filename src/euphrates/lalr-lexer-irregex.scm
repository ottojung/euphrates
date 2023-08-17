;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (make-lalr-lexer/irregex tokens-alist)
  (define offset 0)
  (define linenum 0)
  (define colnum 0)
  (define input-string #f)
  (define input-length #f)

  (define (terminal->regex t)
    (sre->irregex `(seq bos ,t)))

  (define regex-alist
    (map
     (compose-under cons car (comp cdr terminal->regex))
     tokens-alist))

  (define (adjust-positions! s)
    (set! offset (+ offset (string-length s)))

    (define (for-c c)
      (define nl? (equal? c #\newline))
      (when nl? (set! linenum (+ linenum 1)))
      (set! colnum (if nl? 0 (+ 1 colnum))))
    (string-for-each for-c s))

  (define (make-context-string)
     (substring input-string offset (min (+ offset 10) input-length)))

  (lambda _
    (unless input-string
      (set! input-string (read-all-port (current-input-port)))
      (set! input-length (string-length input-string)))

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
        (raisu* :from 'lalr-lexer/irregex
                :type 'lexer-error
                :message "Lexer encountered an unknown sequence of characters"
                :args (list offset (make-context-string))))

      (define-pair (token s) r)
      (adjust-positions! s)

      (let ((location (make-source-location "*stdin*" linenum colnum offset (string-length s))))
        (make-lexical-token token location s)))

    (if (>= offset input-length) '*eoi*
        (process-next))))
