;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (lalr-parser/simple-extract-regexes bnf-alist)
  (define-values (terminal-prefix terminal-prefix/re)
    (let ()
      (define (make-prefix x)
        (string-append "t" (if (= 0 x) "" (~a x)) "_"))
      (define (make-prefix/re x)
        (string-append "r" (if (= 0 x) "" (~a x)) "_"))

      (define lowest-index
        (list-fold
         (acc 0)
         (cur (map ~a (list-collapse bnf-alist)))
         (if (or (string-prefix? (make-prefix acc) cur)
                 (string-prefix? (make-prefix/re acc) cur))
             (+ 1 acc) acc)))

      (values (make-prefix lowest-index)
              (make-prefix/re lowest-index))))

  (define rhss
    (map cdr bnf-alist))

  (define all-expansion-terms
    (apply append (apply append rhss)))

  (define taken-token-names-set
    (list->hashset all-expansion-terms))

  (define (string-terminal? x)
    (string? x))

  (define (re-terminal? x)
    (and (list? x)
         (pair? x)
         (equal? 'class (car x))))

  (define (terminal? x)
    (or (string-terminal? x)
        (re-terminal? x)))

  (define all-terminals
    (list-deduplicate
     (filter terminal? all-expansion-terms)))

  (define (terminal->token t)
    (cond
     ((string-terminal? t)
      (string->symbol (string-append terminal-prefix t)))
     ((re-terminal? t)
      (string->symbol
       (string-append
        terminal-prefix/re
        (apply string-append
               (list-intersperse "_" (map ~a t))))))
     (else (raisu 'impossible t))))

  (define terminal->singlechar
    (curry-if re-terminal? identity))

  (define tokens-map
    (map (compose-under cons terminal->token terminal->singlechar)
         all-terminals))

  (define (translate-terminal x)
    (string->symbol (string-append terminal-prefix x)))

  (define (maybe-translate-terminal x)
    (if (terminal? x)
        (terminal->token x)
        x))

  (define new-alist
    (bnf-alist:map-expansion-terms
     maybe-translate-terminal bnf-alist))

  (values new-alist taken-token-names-set tokens-map))
