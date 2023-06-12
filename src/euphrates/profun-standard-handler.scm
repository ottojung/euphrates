;;;; Copyright (C) 2022  Otto Jung
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



;; A handler that only contains operations that are safe, portable and pure.


(define profun-standard-handler
  (profun-make-handler
   (= profun-op-unify)
   (eq profun-op-unify)
   (!= profun-op-separate)
   (neq profun-op-separate)
   (true profun-op-true)
   (false profun-op-false)
   (+ profun-op+)
   (plus profun-op+)
   (* profun-op*)
   (times profun-op*)
   (modulo profun-op-modulo)
   (sqrt profun-op-sqrt)
   (< profun-op-less)
   (less profun-op-less)
   (divisible profun-op-divisible)
   (equals profun-op-equals)))
