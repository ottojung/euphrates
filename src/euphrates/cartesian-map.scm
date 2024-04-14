;;;; Copyright (C) 2021, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.



(define (cartesian-map function a b)
  (let lp1 ((ai a))
    (if (null? ai) '()
        (let ((av (car ai)))
          (let lp2 ((bi b))
            (if (null? bi)
                (lp1 (cdr ai))
                (cons (function av (car bi))
                      (lp2 (cdr bi)))))))))

