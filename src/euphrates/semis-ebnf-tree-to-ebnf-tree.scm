;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; A "semis-ebnf-tree" is a "semi-structured EBNF tree" (where EBNF = Extended Backus-Naur Form).
;; It is semi-structured when there are terms whose structure
;;   is encoded in their names -
;;   for example a term "expr*" in semis-ebnf-tree
;;   is equivalent to "(* expr)" in ebnf-tree.
;; But the latter is more structured.
(define (semis-ebnf-tree->ebnf-tree equality-symbol alternation-symbol)
  (define equality-symbol/sym
    (string->symbol (~a equality-symbol)))
  (define alternation-symbol/sym
    (string->symbol (~a alternation-symbol)))

  (define (err t modifiers)
    (raisu* :from 'semis-ebnf-tree->ebnf-tree
            :type 'terminal-with-multiple-modifiers
            :message
            (stringf
             "Terminal ~s contains multiple modifiers (~a), but only one is allowed"
             (~a t) (words->string (map ~s (map ~a modifiers))))
            :args (list t modifiers)))

  (lambda (body)
    (define (parse-symbol-term t)
      (define s (~a t))
      (let loop ((s s) (modifiers '()))
        (define n (string-length s))
        (define (recur m s*) (loop s* (cons m modifiers)))

        (cond
         ((string-suffix? "*" s)
          (recur '* (substring s 0 (- n 1))))
         ((string-suffix? "+" s)
          (recur '+ (substring s 0 (- n 1))))
         ((string-suffix? "?" s)
          (recur '? (substring s 0 (- n 1))))
         ((string-prefix? "!" s)
          (recur '! (substring s 1)))

         ((null? modifiers) t)
         ((null? (cdr modifiers))
          (list (car modifiers) (string->symbol s)))
         (else (err t modifiers)))))

    (define parse-term
      (curry-if
       (lambda (t)
         (and (symbol? t)
              (not (equal? equality-symbol/sym t))
              (not (equal? alternation-symbol/sym t))))
       parse-symbol-term))

    (map parse-term body)))
