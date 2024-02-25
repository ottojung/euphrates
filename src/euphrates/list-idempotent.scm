;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (list-idempotent pred lst)
  ;; The `list-idempotent` function takes two arguments:
  ;;   pred: a binary predicate function that defines an equivalence relation on the elements of `lst`
  ;;   lst: a list of elements to be processed
  ;;
  ;; It compares each pair of elements `x, y` in `lst` and only keeps `x`, `y` or both of them,
  ;; depending on the result of `pred`.
  ;; If `(pred x y)` returns `'left`, then `x` is kept.
  ;; If `(pred x y)` returns `'right`, then `y` is kept.
  ;; If `(pred x y)` returns `'ski`, then both are kept.
  ;;
  ;; This operation is related to the mathematical concept of idempotence in the context of set operations.
  ;; In set theory, idempotent operations such as union, intersection, or function composition do not change
  ;; the output upon repeated application. Similarly, `list-idempotent` will ensure that applying the same function
  ;; repeatedly will yield the same list after the first application, as duplicate elements will have been removed.
  ;;
  ;; Example usage:
  ;; (list-idempotent equal? (list 1 2 1 4 1))
  ;; will return
  ;; (list 1 2 4 1)
  ;; keeping only the first appearance of each number.
  ;;
  ;; Note: this function is similar to `list-deduplicate', but with a binary `pred' instead of a unary `identity', and working one step at a time.

  (list-reduce/pairwise

   (lambda (direction x y)
     (define result (pred x y))
     (cond
      ((equal? result 'left)
       (if (equal? direction 'forward)
           x
           (values)))

      ((equal? result 'right)
       (if (equal? direction 'reverse)
           x
           (values)))

      ((equal? result 'skip)
       (values))

      (else
       (raisu* :from "list-idempotent"
               :type 'bad-pred-value
               :message (stringf "Expected either 'left, 'right, or 'skip, but got ~s." (~a result))
               :args (list result direction x y lst)))))

   lst))
