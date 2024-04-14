;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



(define (cartesian-any? predicate a b)
  (let lp ((ai a))
    (if (null? ai) #f
        (or (let ((av (car ai)))
              (let lp ((bi b))
                (if (null? bi) #f
                    (or (predicate av (car bi))
                        (lp (cdr bi))))))
            (lp (cdr ai))))))
