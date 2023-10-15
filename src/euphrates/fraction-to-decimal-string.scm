;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (fraction->decimal-string/tuples n d)
  ;; Calculate the decimal expansion of the fraction
  (define p (quotient n d))
  (define integral (number->string p))
  (define dict (make-hashmap))

  (define after-dot
    (let loop ((n (- n (* p d)))
               (dec (list)))
      (define index (hashmap-ref dict n #f))
      (if (zero? n) dec
          ;; We have seen this numerator before
          (if index
              (let ()
                (define-values (pref repeating)
                  (list-span-n index dec))
                (append pref (list "(") repeating (list ")")))
              ;; Continue the long division method
              (let ()
                (hashmap-set! dict n (length dec))
                (define more-n (* n 10))
                (define new-dec
                  (append dec (list (number->string (quotient more-n d)))))
                (define new-n (remainder more-n d))
                (loop new-n new-dec))))))

  ;; Returning the simplified fraction as string
  (if (null? after-dot) integral
      (string-append
       integral "."
       (apply string-append after-dot))))

(define (fraction->decimal-string x)
  (if (inexact? x)
      (number->string x)
      (let ()
        (define e (inexact->exact x))
        (define n (numerator e))
        (define d (denominator e))
        (fraction->decimal-string/tuples n d))))
