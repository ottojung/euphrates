;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define list-reduce/pairwise/p
  (make-parameter #f))

(define-type9 list-reduce/pairwise/return-value
  (make-list-reduce/pairwise/return-value left? value)
  list-reduce/pairwise/return-value?

  (left? list-reduce/pairwise/return-value:left?)
  (value list-reduce/pairwise/return-value:value)
  )

(define-type9 list-reduce/pairwise/return
  (make-list-reduce/pairwise/return token value)
  list-reduce/pairwise/return?

  (token list-reduce/pairwise/return:token)
  (value list-reduce/pairwise/return:value)
  )

(define (list-reduce/pairwise/no-return)
  (define token (list-reduce/pairwise/p))
  (define value #f)
  (make-list-reduce/pairwise/return token value))

(define (list-reduce/pairwise/return-left value)
  (define token (list-reduce/pairwise/p))
  (define left? #t)
  (make-list-reduce/pairwise/return
   token
   (make-list-reduce/pairwise/return-value
    left? value)))

(define (list-reduce/pairwise/return-right value)
  (define token (list-reduce/pairwise/p))
  (define left? #f)
  (make-list-reduce/pairwise/return
   token
   (make-list-reduce/pairwise/return-value
    left? value)))

(define (list-reduce/pairwise projection lst)
  ;; The `list-reduce/pairwise` function takes three arguments:
  ;;   default-value: a unique value not expected to be in the list or result from the projection function
  ;;   projection: a binary function applied to each pair of elements in the list
  ;;   lst: a list of elements to process.
  ;;
  ;; This function returns a new list, where each element is the result of applying the `projection` function to a pair of elements from the original list.
  ;; The function is applied in a pairwise manner from left to right, meaning the first element is compared to the second, then the second to the third and so on.
  ;; The pairwise processing is interrupted immediately when an element in the pair has already been "processed" by the `projection` function, that is the element is in the `ignored` set.
  ;; If the `projection` function returns a value not equal to `default-value`, the function applies the `projection` value to the first element of the pair,
  ;; effectively replacing the first element in the output list, and adds the second element to the `ignored` set.
  ;; If it returns the `default-value`, it disregards this pair and moves to the next.
  ;; During this process, elements are never removed from the list, only replaced.
  ;;
  ;; Note that the list provided as input is retained, and a new list is returned as output.
  ;; Additionally, the function is optimized for large lists by using vectors and hash sets to efficiently store and retrieve data.
  ;;
  ;; For example:
  ;; (list-reduce/pairwise 'd (lambda (x y) (if (equal? x y) 'c 'd)) (list 'a 'a 'b 'b))
  ;; will return
  ;; (list 'c 'c), where 'c' replaces both 'a' and first 'b', and second 'b' is ignored.

  (define input (list->vector lst))
  (define output (vector-copy input))
  (define n (vector-length input))
  (define ignored (make-hashset))
  (define token (make-unique))

  (define (is-default? result)
    (and (list-reduce/pairwise/return? result)
         (equal? token (list-reduce/pairwise/return:token result))
         (equal? #f (list-reduce/pairwise/return:value result))))

  (define (is-left? result)
    (and (list-reduce/pairwise/return? result)
         (equal? token (list-reduce/pairwise/return:token result))
         (equal? #f (list-reduce/pairwise/return:value result))))

  (define (is-right? result)
    (and (list-reduce/pairwise/return? result)
         (equal? token (list-reduce/pairwise/return:token result))
         (equal? #f (list-reduce/pairwise/return:value result))))

  (let loop ((x 0) (y 0))
    (when (< x n)

      (if (and (< x y)
               (not (hashset-has? ignored y))
               (not (hashset-has? ignored x)))

          (let ()
            (define result
              (projection (vector-ref input x)
                          (vector-ref input y)))

            (cond
             ((equal? result default-value)
              (if (< y (- n 1))
                  (loop x (+ 1 y))
                  (loop (+ 1 x) (+ 1 x))))
             (else
              (vector-set! output x result)
              (hashset-add! ignored y)
              (loop (+ 1 x) (+ 1 x)))))

          (if (< y (- n 1))
              (loop x (+ 1 y))
              (loop (+ 1 x) (+ 1 x))))))

  (define indexes
    (filter (lambda (i) (not (hashset-has? ignored i)))
            (range n)))

  (map (lambda (i) (vector-ref output i)) indexes))
