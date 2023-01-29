;;;; Copyright (C) 2020, 2021, 2022  Otto Jung
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
  (define-module (euphrates profun-op-unify)
    :export (profun-op-unify)
    :use-module ((euphrates profun-accept) :select (profun-accept profun-set))
    :use-module ((euphrates profun-op-lambda) :select (profun-op-lambda))
    :use-module ((euphrates profun-reject) :select (profun-reject))
    :use-module ((euphrates profun-request-value) :select (profun-request-value))
    :use-module ((euphrates profun-variable-equal-q) :select (profun-variable-equal?))
    :use-module ((euphrates raisu) :select (raisu)))))



(define profun-op-unify
  (profun-op-lambda
   (ctx (x y) (x-name y-name))
   (define ret (profun-variable-equal? x y))
   (case ret
     ((#t) (profun-accept))
     ((#f) (profun-reject))
     ((x-false) (profun-set (x-name <- y)))
     ((y-false) (profun-set (y-name <- x)))
     ((both-false) (profun-request-value `(any ,x-name ,y-name)))
     (else (raisu 'impossible-case-for-op-unify ret x y)))))
