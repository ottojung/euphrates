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
  (define-module (euphrates profun-value)
    :export (profun-unbound-value? profun-bound-value? profun-value-unwrap profun-value-name profun-value? profun-make-var profun-make-constant profun-make-unbound-var)
    :use-module ((euphrates define-type9) :select (define-type9)))))



(define-type9 <profun-value>
  (profun-value-constructor value empty? name) profun-value?
  (value profun-value-value)
  (empty? profun-value-empty?) ;; #t if has no value assigned
  (name profun-value-name) ;; name of a top-level variable that binds this value
  )

(define (profun-make-var name val)
  (profun-value-constructor val #f name))

(define (profun-make-constant c)
  (profun-value-constructor c #f #f))

(define (profun-make-unbound-var name)
  (profun-value-constructor #f #t name))

(define (profun-value-unwrap var)
  (if (profun-value-empty? var) var
      (profun-value-value var)))

(define (profun-unbound-value? x)
  (and (profun-value? x)
       (profun-value-empty? x)))
(define (profun-bound-value? x)
  (not (profun-unbound-value? x)))
