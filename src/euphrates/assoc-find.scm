;;;; Copyright (C) 2021, 2022, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




(define-syntax assoc/find
  (syntax-rules ()
    ((_ predicate alist)
     (assoc-find predicate alist (raisu 'could-not-find-the-element alist)))
    ((_ predicate0 alist default)
     (let ((predicate predicate0))
       (let loop ((alist alist))
         (if (null? alist) default
             (let* ((x (car alist))
                    (k (car x)))
               (if (predicate k)
                   x
                   (loop (cdr alist))))))))))


