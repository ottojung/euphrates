;;;; Copyright (C) 2023  Otto Jung
;;;;
;;;; This program is free software: you can redistribute it and/or modify
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
  (define-module (euphrates linear-regression)
    :export (linear-regression))))

(define (linear-regression X Y)
  (let* ((n (length X))
         (sum-x (apply + X))
         (sum-y (apply + Y))
         (sum-x-sq (apply + (map (lambda (x) (* x x)) X)))
         (sum-xy (apply + (map * X Y)))
         (slope (/ (- (* n sum-xy) (* sum-x sum-y)) (- (* n sum-x-sq) (* sum-x sum-x))))
         (intercept (/ (- sum-y (* slope sum-x)) n)))
    (values slope intercept)))
