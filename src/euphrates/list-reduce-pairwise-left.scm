;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (list-reduce/pairwise/left projection lst)
  ;; The `list-reduce/pairwise` function takes three arguments:
  ;;   projection: a binary function applied to each pair of elements in the list
  ;;   lst: a list of elements to process.
  ;;
  ;; This function returns a new list, where each element is the result of applying the `projection` function to a pair of elements from the original list.
  ;; The function is applied in a pairwise manner from left to right, meaning the first element is compared to the second, then the second to the third and so on.
  ;; The pairwise processing is interrupted immediately when an element in the pair has already been "processed" by the `projection` function, that is the element is in the `ignored` set.
  ;; If the `projection` function returns a value not equal to `(values)`, the function applies the `projection` value to the first element of the pair,
  ;; effectively replacing the first element in the output list, and adds the second element to the `ignored` set.
  ;; If it returns the `(values)`, it disregards this pair and moves to the next.
  ;;
  ;; Note that the list provided as input is retained, and a new list is returned as output.
  ;;
  ;; For example:
  ;; (list-reduce/pairwise (lambda (x y) (if (equal? x y) 'c (values))) (list 'a 'a 'b 'b))
  ;; will return
  ;; (list 'c 'c), where 'c' replaces both 'a' and first 'b', and second 'b' is ignored.
  ;;

  (define input (list->vector lst))
  (define output (vector-copy input))
  (define n (vector-length input))
  (define ignored (make-hashset))

  (let loop ((x 0) (y 0))
    (when (< x n)

      (if (and (< x y)
               (not (hashset-has? ignored y))
               (not (hashset-has? ignored x)))
          (let ()
            (define result
              (call-with-values
                  (lambda _
                    (projection (vector-ref input x)
                                (vector-ref input y)))
                list))

            (define value
              (cond
               ((null? result) #f)
               ((null? (cdr result)) (car result))
               (else
                (raisu* :from "list-reduce/pairwise"
                        :type 'bad-number-of-values
                        :message (stringf "Expected either 0 or 1 value, got ~s." (length result))
                        :args (list result x y lst)))))

            (if (null? result)
                (if (< y (- n 1))
                    (loop x (+ 1 y))
                    (loop (+ 1 x) (+ 1 x)))
                (begin
                  (vector-set! output x value)
                  (hashset-add! ignored y)
                  (loop (+ 1 x) (+ 1 x)))))

          (if (< y (- n 1))
              (loop x (+ 1 y))
              (loop (+ 1 x) (+ 1 x))))))

  (let ()
    (define indexes
      (filter (lambda (i) (not (hashset-has? ignored i)))
              (range n)))

    (map (lambda (i) (vector-ref output i)) indexes)))
