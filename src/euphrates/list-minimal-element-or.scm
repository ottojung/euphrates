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
  (define-module (euphrates list-minimal-element-or)
    :export (list-minimal-element-or))))


(define (list-minimal-element-or default projection lst)
  (let loop ((lst lst) (min #f) (min-elem #f))
    (if (null? lst) (if min min-elem default)
        (let* ((x (car lst))
               (p (projection x))
               (new-min (if min (if (< p min) p min) p))
               (new-min-elem (if min (if (< p min) x min-elem) x)))
          (loop (cdr lst) new-min new-min-elem)))))
