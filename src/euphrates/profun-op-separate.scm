;;;; Copyright (C) 2020, 2021, 2022, 2023  Otto Jung
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




(define profun-op-separate
  (profun-op-lambda
   (ctx (x y) (x-name y-name))
   (case (profun-variable-equal? x y)
     ((#t) (profun-reject))
     ((#f) (profun-accept))
     ((x-false) (profun-request-value x-name))
     ((y-false) (profun-request-value y-name))
     ((both-false) (profun-request-value `(or ,x-name ,y-name))))))
