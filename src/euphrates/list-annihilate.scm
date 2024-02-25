;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (list-annihilate pred lst)
  ;; The `list-annihilate` function takes three arguments:
  ;;   pred: a binary predicate function that defines when two elements should be "annihilated" and replaced by `constant`
  ;;   lst: a list of elements to be processed
  ;;
  ;; It returns a new list where, starting from the head of the list,
  ;; every time an element satisfies the predicate `pred` with any preceding element, they are both removed from the list.
  ;; The result list maintains the original structure but with some elements removed.
  ;;
  ;; Example usage:
  ;; (list-annihilate equal? 'c (list 1 2 1 4 1))
  ;; will return
  ;; (list 2 4 1)
  ;; replacing all appearances of the elements that have been "annihilated" with 'c.

  (define unique (make-unique))
  (define replaced
    (list-reduce/pairwise/left
     (lambda (x y)
       (if (pred x y)
           unique
           (values)))
     lst))
  (define filtered
    (filter (lambda (x) (not (equal? x unique)))
            replaced))
  filtered)
