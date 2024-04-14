;;;; Copyright (C) 2021, 2022, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (convert-number-base/number/generic outbase x)
  (define r3 (number->radix3 outbase x))
  (radix3->string r3))

(define (convert-number-base/string/generic inbase outbase s)
  (define r3 (string->radix3 inbase s))
  (define cr3 (radix3:change-base r3 outbase))
  (radix3->string cr3))

(define convert-number-base
  (case-lambda
   ((outbase x)
    (convert-number-base/generic outbase x))
   ((inbase outbase x)
    (convert-number-base/generic inbase outbase x))))

(define convert-number-base/generic
  (case-lambda
   ((outbase x)
    (convert-number-base/number/generic outbase x))
   ((inbase outbase x)
    (convert-number-base/string/generic inbase outbase x))))
