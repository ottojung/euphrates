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

%var list-minimal-element-or

(define (list-minimal-element-or projection lst default)
  (let loop ((lst lst) (min #f) (min-elem #f))
    (if (null? lst) (if min min-elem default)
        (let* ((x (car lst))
               (p (projection x))
               (new-min (if (< p min) p min))
               (new-min-elem (if (< p min) x min-elem)))
          (loop (cdr lst) new-min new-min-elem)))))
