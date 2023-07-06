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



(define (list-minimal-element-or/proj default projection less-than? lst)
  (cond
   ((null? lst) default)
   ((null? (cdr lst)) (car lst))
   (else
    (let loop ((lst (cdr lst))
               (min (car lst))
               (min/p (projection (car lst))))
      (if (null? lst) min
          (let* ((x (car lst))
                 (x/p (projection x))
                 (test (less-than? x/p min/p)))
            (loop (cdr lst)
                  (if test x min)
                  (if test x/p min/p))))))))
