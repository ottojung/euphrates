;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (list-reduce/pairwise default-value projection lst)
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
              (projection (vector-ref input x)
                          (vector-ref input y)))

            (if (equal? result default-value)
                (if (< y (- n 1))
                    (loop x (+ 1 y))
                    (loop (+ 1 x) (+ 1 x)))
                (begin
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
