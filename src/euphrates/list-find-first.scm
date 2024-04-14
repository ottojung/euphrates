;;;; Copyright (C) 2021, 2022, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




(define-syntax list-find-first
  (syntax-rules ()
    ((_ f lst)
     (list-find-first
      f (raisu 'no-first-element-to-satisfy-predicate f)
      lst))
    ((_ f0 default lst0)
     (let ((f f0) (lst lst0))
       (let loop ((lst lst))
         (if (null? lst) default
             (let ((x (car lst)))
               (if (f x) x
                   (loop (cdr lst))))))))))
