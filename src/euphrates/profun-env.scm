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

%run guile

%var make-profun-env
%var profun-env-get
%var profun-env-set!
%var profun-env-unset!
%var profun-env-copy

%use (hashmap-copy hashmap-delete! hashmap-ref hashmap-set! make-hashmap) "./hashmap.scm"
%use (profun-meta-key) "./profun-meta-key.scm"
%use (profun-bound-value? profun-make-constant profun-make-unbound-var) "./profun-value.scm"
%use (profun-varname?) "./profun-varname-q.scm"

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
