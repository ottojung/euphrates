;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (list-reduce/pairwise projection lst)
  ;; The `list-reduce/pairwise` function takes two arguments:
  ;;   projection: a binary function applied to each pair of elements in the list
  ;;   lst: a list of elements to process.
  ;;
  ;; This function returns a new list, where each element is the result of applying the `projection` function to a pair of elements from the original list, including a direction argument.
  ;; The function is applied in a pairwise manner from left to right and right to left, meaning the first element is compared to the second, then the second to the third and so on.
  ;;
  ;; The pairwise processing is interrupted immediately when an element in the pair has already been "processed" by the `projection` function, that is the element is in the `ignored` set.
  ;; If the `projection` function returns a tuple of `(values)`, it disregards this pair and moves to the next.
  ;; If it returns a tuple of `(values x)`, where x is not a null value, 
  ;; the function applies the `projection` value to the first element of the pair in the 'forward' direction or the second element of the pair in the 'reverse' direction,
  ;; effectively replacing the specified element in the output list, and adds the pair to the `ignored` set.
  ;;
  ;; During this process, elements are never removed from the list, only replaced.
  ;; The processed values are stored in the 'taken' set.
  ;;
  ;; Note that the list provided as input is retained, and a new list is returned as output.
  ;; Additionally, the function is optimized for large lists by using vectors and hash sets to efficiently store and retrieve data.
  ;;
  ;; For example:
  ;; (list-reduce/pairwise (lambda (direction x y) (if (equal? x y) (values 'c) (values))) (list 'a 'a 'b 'b))
  ;; will return
  ;; (list 'c 'c), where 'c' replaces both 'a' and first 'b', and second 'b' is ignored.
  ;;

  (define input (list->vector lst))
  (define output (vector-copy input))
  (define n (vector-length input))
  (define ignored (make-hashset))
  (define taken (make-hashset))

  (define (unwrap-value result)
    (if (null? result) (values #f #f) (apply values result)))

  (let loop ((x 0) (y 0))
    (when (< x n)

      (if (and (not (= x y))
               (not (hashset-has? ignored y))
               (not (hashset-has? ignored x)))

          (let ()
            (define direction
              (if (< x y) 'forward 'reverse))

            (define result
              (call-with-values
                  (lambda _
                    (projection direction
                                (vector-ref input x)
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

            (cond
             ((null? result)
              (if (< y (- n 1))
                  (loop x (+ 1 y))
                  (loop (+ 1 x) (+ 1 x))))
             ((equal? direction 'forward)
              (vector-set! output x value)
              (hashset-add! ignored x)
              (hashset-add! ignored y)
              (hashset-add! taken x)
              (hashset-delete! taken y)
              (loop (+ 1 x) (+ 1 x)))
             (else
              (vector-set! output y value)
              (hashset-add! ignored x)
              (hashset-add! ignored y)
              (hashset-add! taken y)
              (hashset-delete! taken x)
              (loop (+ 1 x) (+ 1 x)))))

          (if (< y (- n 1))
              (loop x (+ 1 y))
              (loop (+ 1 x) (+ 1 x))))))

  (let ()
    (define indexes
      (filter (lambda (i) (hashset-has? taken i))
              (range n)))

    (map (lambda (i) (vector-ref output i)) indexes)))
