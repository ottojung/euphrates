;;;; Copyright (C) 2020, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



;; Returns procedure that returns #t if applied to itself, #f otherwise
;; But it is probably faster too do (eq? (make-unique) other)
(define (make-unique)
  (let ((euphrates-unique #f))
    (set! euphrates-unique (lambda (other)
                 (eq? other euphrates-unique)))
    euphrates-unique))

