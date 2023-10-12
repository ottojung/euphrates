;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn-load serialized-vect)
  (unless (and (vector? serialized-vect)
               (= 8 (vector-length serialized-vect))
               (equal? serialized-parser-typetag
                       (vector-ref serialized-vect 0)))
    (raisu* :from "parselynn-load"
            :type 'type-error
            :message "The input object is not a serialized parser"
            :args (list serialized-vect)))

  (define struct
    (make-parselynn-struct
     (vector-ref serialized-vect 1)
     (vector-ref serialized-vect 2)
     (vector-ref serialized-vect 3)
     (vector-ref serialized-vect 4)
     (vector-ref serialized-vect 5)
     (vector-ref serialized-vect 6)
     (vector-ref serialized-vect 7)))

  struct)
