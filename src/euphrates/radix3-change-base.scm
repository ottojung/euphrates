;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (radix3:change-base r3 new-base)
  (define existing-basevector (radix3:basevector r3))
  (define new-basevector (radix3:parse-basevector new-base))
  (if (= (vector-length existing-basevector)
         (vector-length new-basevector))
      (radix3:constructor
       (radix3:sign r3)
       (radix3:intpart r3)
       (radix3:fracpart r3)
       (radix3:period r3)
       new-basevector)
      (number->radix3
       new-basevector
       (radix3->number r3))))
