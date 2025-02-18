;;;; Copyright (C) 2021, 2023, 2025  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (list-take-while predicate lst)
  (let loop ((lst lst))
    (if (null? lst) '()
        (let ()
          (define-pair (first rest) lst)
          (if (predicate first)
              (cons first (loop rest))
              '())))))
