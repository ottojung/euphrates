;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (fraction->radix3 base x)
  (define e (inexact->exact x))
  (define n (numerator e))
  (define d (denominator e))
  (define p (quotient n d))
  (define dict (make-hashmap))

  (define default-base alphanum-lowercase/alphabet)
  (define maxnumbase (vector-length default-base))
  (define basevector
    (cond
     ((vector? base) base)
     ((number? base)
      (cond
       ((or (> 2 base) (< maxnumbase base))
        (raisu* :from "fraction->radix3"
                :type 'type-error
                :message
                (stringf
                 "If base is a number, then it must be in the [2, ~s] range"
                 maxnumbase)
                :args (list base maxnumbase)))

       ((or (not (integer? base)) (inexact? base))
        (raisu* :from "fraction->radix3"
                :type 'type-error
                :message "If base is a number, then it must be a whole exact integer"
                :args (list base)))

       (else
        (list->vector (list-take-n base (vector->list default-base))))))

     (else
      (raisu* :from "fraction->radix3"
              :type 'type-error
              :message "Base expected to be a number or a vector"
              :args (list base)))))

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
      (define index (hashmap-ref dict n #f))
      (if (zero? n) (values dec '())
          (if index
              (let ()
                (define-values (pref repeating)
                  (list-span-n index dec))
                (values pref repeating))

              (let ()
                (hashmap-set! dict n (length dec))
                (define more-n (* n numbase))
                (define new-dec
                  (append dec (list (quotient more-n d))))
                (define new-n (remainder more-n d))
                (loop new-n new-dec))))))

  (define ret
    (radix3-constructor
     sign intpart fracpart period basevector))

  ret)
