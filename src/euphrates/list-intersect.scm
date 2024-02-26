;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (list-intersect list-a list-b)
  (let loop ((list-b list-b) (ret '()))
    (if (null? list-b) (reverse ret)
        (let ()
          (define x (car list-b))
          (if (member x list-a)
              (loop (cdr list-b) (cons x ret))
              (loop (cdr list-b) ret))))))
