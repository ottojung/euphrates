;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (list-annihilate pred constant lst)
  ;; The `list-annihilate` function takes three arguments:
  ;;   pred: a binary predicate function that defines when two elements should be "annihilated" and replaced by `constant`
  ;;   constant: the value to be used as a replacement for the annihilated elements
  ;;   lst: a list of elements to be processed
  ;;
  ;; It returns a new list where, starting from the head of the list,
  ;; every time an element satisfies the predicate `pred` with any preceding element, both get replaced by `constant`.
  ;; The result list maintains the original structure but with elements replaced by `constant` as defined by the predicate.
  ;;
  ;; Example usage:
  ;; (list-annihilate equal? 'c (list 1 2 1 4 1))
  ;; will return
  ;; (list 'c 2 'c 4 'c)
  ;; replacing all appearances of the elements that have been "annihilated" with 'c.

  (define input (list->vector lst))
  (define output (copy-vector input))
  (define n (vector-length input))

  (let loop ((x 0) (y 0))
    (when (< x n)

      (unless (= x y)
        (if (pred (vector-ref input x)
                  (vector-ref input y))
            

      (if (< y (- n 1))
          (loop x (+ 1 y))
          (loop (+ 1 x) 0))))

  (vector->list output))
