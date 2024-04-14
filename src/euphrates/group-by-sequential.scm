;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



;; Splits `lst' into groups that
;;  are closed under (predicate x[n] x[n+1:])
;; NOTE: order is preserved
;; NOTE: second argument is a list!
(define (group-by/sequential* predicate lst)
  (if (null? lst) '()
      (let loop ((lst lst) (g (list (car lst))) (buf '()))
        (cond
         ((null? (cdr lst))
          (if (null? g)
              (reverse buf)
              (reverse (cons (reverse g) buf))))
         (else
          (let* ((x (car lst))
                 (xs (cdr lst))
                 (y (car xs))
                 (p? (predicate x xs)))
            (loop (cdr lst)
                  (if p?
                      (cons y g)
                      (list y))
                  (if p? buf (cons (reverse g) buf)))))))))

;; Same as `group-by/sequential*'
;;  but predicate works on single elements
(define (group-by/sequential predicate lst)
  (group-by/sequential*
   (lambda (x xs)
     (or (null? xs)
         (predicate x (car xs))))
   lst))
