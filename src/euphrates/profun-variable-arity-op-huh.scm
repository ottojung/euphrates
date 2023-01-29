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
  (define-module (euphrates profun-variable-arity-op-huh)
    :export (profun-variable-arity-op?)
    :use-module ((euphrates profun-op-obj) :select (profun-op-arity))
    :use-module ((euphrates profun-variable-arity-op-keyword) :select (profun-variable-arity-op-keyword)))))



(define (profun-variable-arity-op? handler)
  (equal? (profun-op-arity handler)
          profun-variable-arity-op-keyword))
