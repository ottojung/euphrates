;;;; Copyright (C) 2023  Otto Jung
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



(define (list-maximal-element-or/proj default projection greater-than? lst)
  (if (null? lst) default
      (let loop ((lst (cdr lst))
                 (max (car lst))
                 (max/p (projection (car lst))))
        (if (null? lst) max
            (let* ((x (car lst))
                   (x/p (projection x))
                   (test (greater-than? x/p max/p)))
              (loop (cdr lst)
                    (if test x max)
                    (if test x/p max/p)))))))
