;;;; Copyright (C) 2022  Otto Jung
;;;;
;;;; This program is free software; you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; version 3 of the License.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.




;; Represents equation "y * q + r = x | q != 0 & x => y"
(define profun-op-modulo
  (profun-op-lambda
   (ctx (x y q r) (x-name y-name q-name r-name))

   (define (in-op-domain? x)
     (and (integer? x) (>= x 0)))

   (define check
     (case-lambda
      ((current-value)
       (check current-value (profun-accept)))
      ((current-value next)
       (if (or (in-op-domain? current-value)
               (profun-unbound-value? current-value))
           next
           (profun-reject)))))

   (define (check-all next)
     (check x (check y (check q (check r next)))))

   (define check-or-set
     (case-lambda
      ((name current-value true-value)
       (check-or-set name current-value true-value (profun-accept)))
      ((name current-value true-value next)
       (if (in-op-domain? true-value)
           (if (profun-bound-value? current-value)
               (if (equal? true-value current-value)
                   next
                   (profun-reject))
               (profun-set (name <- true-value) next))
           (profun-reject)))))

   (define (div-op)
     (if (< x y)
         (profun-reject)
         (check-or-set
          r-name r (remainder x y)
          (check-or-set
           q-name q (quotient x y)))))

   (define (get-x)
     (check-or-set
      x-name x (+ (* y q) r)))

   (define (get-y)
     (check-or-set
      y-name y (/ (- x r) q)))

   (define (get-xy)
     (if (profun-unbound-value? q)
         (profun-request-value `(any ,x-name ,q-name))
         (case q
           ((0)
            (if (profun-bound-value? r)
                (check-or-set x-name x r)
                (profun-request-value `(any ,x-name ,r-name))))
           ((1)
            (cond
             ((profun-unbound-value? r)
              (profun-request-value `(any ,x-name ,r-name)))
             ((equal? r 0)
              (profun-request-value x-name))
             (else (profun-reject))))
           (else
            (cond
             ((profun-unbound-value? r)
              (profun-request-value `(any ,x-name ,r-name)))
             ((equal? r 0)
              (check-or-set x-name x 0))
             (else (profun-reject)))))))

   (define (eq-xq)
     (define result
       (check-or-set
        y-name y 1
        (check-or-set
         r-name r 0)))

     (cond
      ((profun-bound-value? x) result)
      ((profun-accept? result)
       (profun-request-value x-name))
      (else (profun-reject))))

   (define (get-xr)
     (check-or-set
      y-name y 0
      (check-or-set
       q-name q 0)))

   (define (get-yq)
     (if (> r x)
         (profun-reject)
         (if (and (profun-bound-value? x)
                  (profun-bound-value? r))
             (check-or-set y-name y (sqrt (- x r)))
             (profun-request-value y-name))))

   (define (get-yr)
     (if (and (profun-bound-value? x)
              (profun-bound-value? q))
         (check-or-set
          y-name y (/ x (+ q 1)))
         (profun-request-value y-name)))

   (define (eq-qr)
     (case x
       ((0)
        (if (profun-bound-value? q)
            (if (equal? q 0)
                (profun-request-value y-name)
                (profun-reject))
            (profun-request-value `(any ,y-name ,q-name))))
       (else (profun-reject))))

   (check-all
    (cond
     ((and (profun-bound-value? x)
           (profun-bound-value? y))
      (div-op))
     ((and (profun-bound-value? y)
           (profun-bound-value? q)
           (profun-bound-value? r))
      (get-x))
     ((and (profun-bound-value? x)
           (profun-bound-value? r)
           (profun-bound-value? q))
      (get-y))
     ((equal? x y) (get-xy))
     ((equal? x q) (eq-xq))
     ((and (profun-unbound-value? x)
           (equal? x r))
      (get-xr))
     ((and (profun-unbound-value? y)
           (equal? y q))
      (get-yq))
     ((and (profun-unbound-value? y)
           (equal? y r))
      (get-yr))
     ((equal? q r) (eq-qr))
     (else
      (profun-request-value `(any ,x-name ,y-name ,q-name ,r-name)))))))
