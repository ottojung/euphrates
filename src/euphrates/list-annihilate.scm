;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (list-annihilate pred constant lst)
  ;; The `list-annihilate` function takes three arguments:
  ;;   pred: a binary predicate function that defines when two elements should be "annihilated" and replaced by `constant`
  ;;   constant: the value to be used as a replacement for the annihilated elements
  ;;   lst: a list of elements to be processed
  ;;
  ;; It returns a new list where, starting from the head of the list,
  ;; every time an element satisfies the predicate `pred` with any preceding element, it is replaced by `constant`.
  ;; The result list maintains the original order of the first occurrence of each non-annihilated element.
  ;;
  ;; Example usage:
  ;; (list-annihilate equal? 'c (list 'a 'b 'a 'd 'a))
  ;; will return
  ;; (list 'a 'b 'c 'd 'c)
  ;; replacing subsequent appearances of previously encountered elements (according to `pred`) with 'c.

  (let loop ((rest lst) (result '()))
    (cond
     ((null? rest) (reverse result))
     ((list-or-map (lambda (x) (pred x (car rest))) result)
      (loop (cdr rest) (cons constant result)))
     (else
      (loop (cdr rest) (cons (car rest) result))))))
