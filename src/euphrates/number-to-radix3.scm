;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (number->radix3 base x)
  (define e (inexact->exact x))
  (define n (numerator e))
  (define d (denominator e))
  (define p (quotient n d))
  (define dict
    (if (integer? x) 'should-not-be-needed
        (make-hashmap)))

  (define basevector
    (radix3:parse-basevector base))

  (define numbase
    (vector-length basevector))

  (define sign
    (if (< x 0) -1 1))

  (define (number->list n)
    (if (< n numbase)
        (list n)
        (append (number->list (quotient n numbase))
                (list (remainder n numbase)))))

  (define intpart
    (number->list (abs p)))

  (define-values (fracpart period)
    (let loop ((n (abs (- n (* p d))))
               (dec (list)))

      (if (zero? n) (values (reverse dec) '())
          (let ()
            (define index (hashmap-ref dict n #f))
            (if index
                (let ()
                  (define-values (pref repeating)
                    (list-span-n index (reverse dec)))
                  (values pref repeating))

                (let ()
                  (define more-n (* n numbase))
                  (define new-dec
                    (cons (quotient more-n d) dec))
                  (define new-n (remainder more-n d))
                  (hashmap-set! dict n (length dec))
                  (loop new-n new-dec)))))))

  (define ret
    (radix3:constructor
     sign intpart fracpart period basevector))

  ret)
