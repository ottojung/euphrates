;;;; Copyright (C) 2020, 2021  Otto Jung
;;;;
;;;; This program is free software; you can redistribute it and/or modify
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
  (define-module (euphrates list-and-map)
    :export (list-and-map))))


(define list-and-map
  (case-lambda
   ((f lst)
    (let loop ((buf lst))
      (if (null? buf) #t
          (if (f (car buf))
              (loop (cdr buf))
              #f))))
   ((f lst1 lst2)
    ;; TODO: extend to any number of args.
    (let loop ((lst1 lst1) (lst2 lst2))
      (if (null? lst1) (null? lst2)
          (if (null? lst2) #f
              (if (f (car lst1) (car lst2))
                  (loop (cdr lst1) (cdr lst2))
                  #f)))))))
