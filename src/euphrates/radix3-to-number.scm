;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (radix3->number r3)
  (define basevector (radix3:basevector r3))
  (define numbase (vector-length basevector))

  (define (radix-list->number lst)
    (let loop ((ret 0)
               (powmult 1)
               (rest (reverse lst)))
      (if (null? rest) ret
          (loop (+ ret (* powmult (car rest)))
                (* numbase powmult)
                (cdr rest)))))

  (define integral (radix3:intpart r3))
  (define fractional (radix3:fracpart r3))
  (define period (radix3:period r3))

  (define num
    (if (null? period)
        (radix-list->number (append integral fractional))
        (- (radix-list->number (append integral fractional period))
           (radix-list->number (append integral fractional)))))

  (define den
    (if (null? period)
        (expt numbase (length fractional))
        (- (expt numbase (+ (length period) (length fractional)))
           (expt numbase (length fractional)))))

  (define sign
    (radix3:sign r3))

  (* sign (/ num den)))
