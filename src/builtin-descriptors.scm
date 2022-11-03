;;;; Copyright (C) 2022  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
;;;; it under the terms of the GNU General Public License as published by
;;;; the Free Software Foundation; version 3 of the License.
;;;;
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;;
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

%run guile

%var builtin-descriptors

%use (atomic-box?) "./atomic-box.scm"
%use (box?) "./box.scm"

(define (make-builtin-descriptor name predicate)
  `((name . ,name)
    (predicate . ,predicate)
    (builtin . #t)
    ))

(define builtin-descriptors
  (list
   (make-builtin-descriptor 'number number?)
   (make-builtin-descriptor 'string string?)
   (make-builtin-descriptor 'symbol symbol?)
   (make-builtin-descriptor 'char char?)
   (make-builtin-descriptor 'true (lambda (x) (equal? x #t)))
   (make-builtin-descriptor 'false (lambda (x) (equal? x #f)))
   (make-builtin-descriptor 'list list?)
   (make-builtin-descriptor 'cons pair?)
   (make-builtin-descriptor 'vector vector?)
   (make-builtin-descriptor 'parameter parameter?)
   (make-builtin-descriptor 'unspecified (lambda (x) (equal? x (when #f #f))))
   (make-builtin-descriptor 'eof eof-object?)

%for (COMPILER "guile")
   (make-builtin-descriptor 'hash-table hash-table?)
%end

   (make-builtin-descriptor 'box box?)
   (make-builtin-descriptor 'atomic-box atomic-box?)

   (make-builtin-descriptor 'procedure procedure?)
   ))
