;;;; Copyright (C) 2021, 2022, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.




(define (list-chunks block-size lst)
  (let loop ((lst lst) (ret '()))
    (if (null? lst) (reverse ret)
        (call-with-values
            (lambda _ (list-span-n block-size lst))
          (lambda (left right)
            (loop right (cons left ret)))))))
