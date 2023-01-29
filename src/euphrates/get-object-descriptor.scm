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

(cond-expand
 (guile
  (define-module (euphrates get-object-descriptor)
    :export (get-object-descriptor)
    :use-module ((euphrates builtin-descriptors) :select (builtin-descriptors))
    :use-module ((euphrates define-type9) :select (type9-get-record-descriptor))
    :use-module ((euphrates list-map-first) :select (list-map-first)))))



(define (get-object-descriptor obj)
  (or
   (list-map-first
    (lambda (descriptor)
      (define predicate (cdr (assoc 'predicate descriptor)))
      (and (predicate obj) descriptor))
    #f builtin-descriptors)
   (type9-get-record-descriptor obj)))
