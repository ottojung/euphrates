;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (list-idempotent pred lst)
  ;; The `list-idempotent` function takes two arguments:
  ;;   pred: a binary predicate function that defines an equivalence relation on the elements of `lst`
  ;;   lst: a list of elements to be processed
  ;;
  ;; It returns a new list that contains the first occurrence of each element in `lst`,
  ;; removing all subsequent elements that satisfy the predicate `pred` with respect to any previously encountered element.
  ;; The result list preserves the order of first occurrence of each unique element as they originally appear in `lst`.
  ;;
  ;; This operation is related to the mathematical concept of idempotence in the context of set operations.
  ;; In set theory, idempotent operations such as union, intersection, or function composition do not change
  ;; the output upon repeated application. Similarly, `list-idempotent` will ensure that applying the same function
  ;; repeatedly will yield the same list after the first application, as duplicate elements will have been removed.
  ;;
  ;; It is also connected to the concept of equivalence relations and equivalence classes. A relation `R` on a set `A`
  ;; is defined as an equivalence relation if it is reflexive, symmetric, and transitive. As such, `R` partitions `A` into
  ;; equivalence classes where all elements related by `R` are considered equivalent. `list-idempotent` saves only the first
  ;; representative of each equivalence class according to `pred` and removes the rest.
  ;;
  ;; Example usage:
  ;; (list-idempotent equal? (list 1 2 1 4 1))
  ;; will return
  ;; (list 1 2 4)
  ;; keeping only the first appearance of each number.
  ;;
  ;; Note: this function is `list-deduplicate', but with a binary `pred' instead of a unary `identity'.

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
           y
           (values)))

      ((equal? result 'skip) 0)

      (else
       (raisu* :from "list-idempotent"
               :type 'bad-pred-value
               :message (stringf "Expected either 'left, 'right, or 'skip, but got '~a." result)
               :args (list result direction x y lst)))))

   lst))
