;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:citizen:r7rs:make code)
  (vector 'r7rs code))

(define (labelinglogic:citizen:r7rs? obj)
  (and (vector? obj)
       (= 2 (vector-length obj))
       (equal? 'r7rs (vector-ref obj 0))))

(define (labelinglogic:citizen:r7rs:code obj)
  (vector-ref obj 1))
