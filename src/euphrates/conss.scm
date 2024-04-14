;;;; Copyright (C) 2020, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(cond-expand
 (racket
  (define conss list*))
 (else
  (define conss
    (case-lambda
     ((x) x)
     ((x y) (cons x y))
     ((x y . rest)
      (let loop ((x x) (y y) (rest rest))
        (if (null? rest)
            (cons x y)
            (cons x (loop y (car rest) (cdr rest))))))))))
