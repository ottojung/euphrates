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
  (define-module (euphrates profun-env)
    :export (make-profun-env profun-env-get profun-env-set! profun-env-unset! profun-env-copy)
    :use-module ((euphrates hashmap) :select (hashmap-copy hashmap-delete! hashmap-ref hashmap-set! make-hashmap))
    :use-module ((euphrates profun-meta-key) :select (profun-meta-key))
    :use-module ((euphrates profun-value) :select (profun-bound-value? profun-make-constant profun-make-unbound-var))
    :use-module ((euphrates profun-varname-q) :select (profun-varname?)))))



(define (make-profun-env)
  (make-hashmap))
(define (profun-env-get env key)
  (if (profun-varname? key)
      (hashmap-ref env key (profun-make-unbound-var key))
      (profun-make-constant key)))
(define (profun-env-set! env key value)
  (if (profun-bound-value? value)
      (hashmap-set! env key value)
      (hashmap-delete! env key)))
(define (profun-env-unset! env key)
  (hashmap-delete! env key))
(define (profun-env-copy env)
  (hashmap-copy env))

(define (profun-env-get-meta env key)
  (define true-key (profun-meta-key key))
  (profun-env-get env true-key))
