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




;; Returns values of type
;; (((projection x1) x1 x2 x3 ...) ((projection y1) y2 y3 ...) ...)
;; for `lst' = `(x1 x2 x3 ... y1 y2 y3 ...)`
(define (list-group-by projection lst)
  (define H (make-hashmap))
  (for-each
   (lambda (x)
     (define result (projection x))
     (define existing (hashmap-ref H result '()))
     (hashmap-set! H result (cons x existing)))
   lst)
  (hashmap->alist H))
