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

(cond-expand
 (guile
  (define-module (euphrates profun-standard-handler)
    :export (profun-standard-handler)
    :use-module ((euphrates profun-handler) :select (profun-make-handler))
    :use-module ((euphrates profun-op-divisible) :select (profun-op-divisible))
    :use-module ((euphrates profun-op-equals) :select (profun-op-equals))
    :use-module ((euphrates profun-op-false) :select (profun-op-false))
    :use-module ((euphrates profun-op-less) :select (profun-op-less))
    :use-module ((euphrates profun-op-modulo) :select (profun-op-modulo))
    :use-module ((euphrates profun-op-mult) :select (profun-op*))
    :use-module ((euphrates profun-op-plus) :select (profun-op+))
    :use-module ((euphrates profun-op-separate) :select (profun-op-separate))
    :use-module ((euphrates profun-op-sqrt) :select (profun-op-sqrt))
    :use-module ((euphrates profun-op-true) :select (profun-op-true))
    :use-module ((euphrates profun-op-unify) :select (profun-op-unify)))))


;; A handler that only contains operations that are safe, portable and pure.


(define profun-standard-handler
  (profun-make-handler
   (= profun-op-unify)
   (!= profun-op-separate)
   (true profun-op-true)
   (false profun-op-false)
   (+ profun-op+)
   (* profun-op*)
   (modulo profun-op-modulo)
   (sqrt profun-op-sqrt)
   (< profun-op-less)
   (divisible profun-op-divisible)
   (equals profun-op-equals)))
