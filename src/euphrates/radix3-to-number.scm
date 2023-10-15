;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (radix3->number r3)
  (define basevector (radix3:basevector r3))
  (define numbase (vector-length basevector))
  (define r0 (vector-ref basevector 0))
  (define r9 (vector-ref basevector (- numbase 1)))

  (define (number-list->string lst)
    (apply
     string
     (map (lambda (c) (vector-ref basevector c)) lst)))

  (define integral (number-list->string (radix3:intpart r3)))
  (define fractional (number-list->string (radix3:fracpart r3)))
  (define period (number-list->string (radix3:period r3)))

  (define num
    (if (string-null? period)
        (string->number (string-append integral fractional))
        (- (string->number (string-append integral fractional period))
           (string->number (string-append integral fractional)))))

  (define den
    (if (string-null? period)
        (expt numbase (string-length fractional))
        (string->number
         (string-append
          (make-string (string-length period) r9)
          (make-string (string-length fractional) r0)))))

  (/ num den))
