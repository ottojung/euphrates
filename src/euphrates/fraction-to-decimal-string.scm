;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (fraction->decimal-string/tuples n d)
  ;; Calculate the decimal expansion of the fraction
  (define p (quotient n d))
  (set! n (- n (* p d)))
  (define dec (list))
  (define dict (make-hashmap))

  ;; Until the numerator becomes 0
  (let loop ()
    (define index (hashmap-ref dict n #f))
    (unless (zero? n)
      ;; We have seen this numerator before
      (if index
          (let ()
            (define-values (pref repeating)
              (list-span-n index dec))
            (set! dec (append pref (list "(") repeating (list ")"))))
          ;; Continue the long division method
          (begin
            (hashmap-set! dict n (length dec))
            (set! n (* n 10))
            (set! dec (append dec (list (number->string (quotient n d)))))
            (set! n (remainder n d))
            (loop)))))

  ;; Returning the simplified fraction as string
  (string-append (number->string p) "." (apply string-append dec)))

(define (fraction->decimal-string x)
  (define n (numerator x))
  (define d (denominator x))
  (fraction->decimal-string/tuples n d))
