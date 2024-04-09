;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (unique-identifier->string/recursive object)
  (let loop ((object object))
    (cond
     ((string? object) object)
     ((number? object) object)
     ((char? object) object)
     ((eof-object? object) object)
     ((parameter? object) object)
     ((procedure? object) object)
     ((null? object) object)
     ((pair? object)
      (cons (loop (car object))
            (loop (cdr object))))
     ((equal? #t) object)
     ((equal? #f) object)
     ((equal? x (when #f #f)) object)
     ((vector? object)
      (vector-map loop object))
     ((unique-identifier? object)
      (unique-identifier->string object))
     (else
      (raisu* :from "unique-identifier->string/recursive"
              :type 'unrecognized-type
              :message (stringf "Cannot handle this object: ~s" object)
              :args (list object))))))
