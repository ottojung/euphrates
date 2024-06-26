;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (list-consume pred lst)
  ;; The `list-consume` function takes two arguments:
  ;;   pred: a binary predicate function that defines an equivalence relation on the elements of `lst`
  ;;   lst: a list of elements to be processed
  ;;
  ;; It compares each pair of elements `x, y` in `lst` and only keeps `x`, `y` or both of them,
  ;; depending on the result of `pred`.
  ;; If `(pred x y)` returns `'left`, then `x` is kept.
  ;; If `(pred x y)` returns `'right`, then `y` is kept.
  ;; If `(pred x y)` returns `'skip`, then both are kept.
  ;;
  ;; Example usage:
  ;; (list-consume (lambda (x y) (if (equal? x y) 'left 'skip)) (list 1 2 1 4 1))
  ;; will return
  ;; (list 1 2 4 1)
  ;; keeping only the first appearance of each number.
  ;;
  ;; Best used together with `apply-until-fixpoint`.
  ;;

  (list-reduce/pairwise

   (lambda (direction x y)
     (define forward? (equal? direction 'forward))
     (define reverse? (equal? direction 'reverse))
     (define left-element (if forward? x y))
     (define right-element (if forward? y x))
     (define result (pred left-element right-element))

     (cond
      ((equal? result 'left)
       (if forward? left-element (values)))
      ((equal? result 'right)
       (if reverse? right-element (values)))
       ;; (values))
      ((equal? result 'skip) (values))
      (else
       (raisu* :from "list-consume"
               :type 'bad-pred-value
               :message (stringf "Expected either 'left, 'right, or 'skip, but got ~s." (~a result))
               :args (list result direction x y lst)))))

   lst))
