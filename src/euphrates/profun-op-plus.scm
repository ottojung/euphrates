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




(define profun-op+
  (let ((div2
         (lambda (x y)
           (/ x 2)))
        (l/r-identity
         (lambda (x y)
           (case x
             ((0) 'op-binary-rfc)
             (else #f)))))
    (profun-op-binary + - - div2 l/r-identity l/r-identity)))
