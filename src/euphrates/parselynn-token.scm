;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define parselynn:token:typetag
  '*lexical-token*)

(define (parselynn:token:make category source value)
  (vector parselynn:token:typetag category source value))

(define (parselynn:token? x)
  (and (vector? x)
       (= 4 (vector-length x))
       (equal? (vector-ref x 0) parselynn:token:typetag)))

(define (parselynn:token:category x)
  (vector-ref x 1))

(define (parselynn:token:source x)
  (vector-ref x 2))

(define (parselynn:token:value x)
  (vector-ref x 3))
