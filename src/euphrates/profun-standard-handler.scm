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

%run guile

%var profun-standard-handler

;; A handler that only contains operations that are safe, portable and pure.

%use (profun-make-handler) "./profun-handler.scm"
%use (profun-op-divisible) "./profun-op-divisible.scm"
%use (profun-op-equals) "./profun-op-equals.scm"
%use (profun-op-false) "./profun-op-false.scm"
%use (profun-op-less) "./profun-op-less.scm"
%use (profun-op-modulo) "./profun-op-modulo.scm"
%use (profun-op*) "./profun-op-mult.scm"
%use (profun-op+) "./profun-op-plus.scm"
%use (profun-op-separate) "./profun-op-separate.scm"
%use (profun-op-sqrt) "./profun-op-sqrt.scm"
%use (profun-op-true) "./profun-op-true.scm"
%use (profun-op-unify) "./profun-op-unify.scm"

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
