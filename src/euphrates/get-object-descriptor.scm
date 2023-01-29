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

%var get-object-descriptor

%use (builtin-descriptors) "./builtin-descriptors.scm"
%use (type9-get-record-descriptor) "./define-type9.scm"
%use (list-map-first) "./list-map-first.scm"

(define (get-object-descriptor obj)
  (or
   (list-map-first
    (lambda (descriptor)
      (define predicate (cdr (assoc 'predicate descriptor)))
      (and (predicate obj) descriptor))
    #f builtin-descriptors)
   (type9-get-record-descriptor obj)))
