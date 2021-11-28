;;;; Copyright (C) 2021  Otto Jung
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

%run guile

%var lexical-scope-make
%var lexical-scope-set!
%var lexical-scope-ref
%var lexical-scope-stage!
%var lexical-scope-unstage!

%use (lexical-scope-wrap lexical-scope-unwrap) "./lexical-scope-obj.scm"
%use (make-hashmap hashmap-ref hashmap-set!) "./ihashmap.scm"
%use (stack-make stack-peek stack->list stack-push! stack-discard!) "./stack.scm"
%use (make-unique) "./make-unique.scm"

(define (lexical-scope-make)
  (define st (stack-make))
  (stack-push! st (make-hashmap))
  (lexical-scope-wrap st))

(define (lexical-scope-set! scope key value)
  (define st (lexical-scope-unwrap scope))
  (define H (stack-peek st))
  (hashmap-set! H key value)
  (values))

(define (lexical-scope-ref scope key default)
  (define st (lexical-scope-unwrap scope))
  (define lst (stack->list st))
  (define unique (make-unique))
  (let loop ((lst lst))
    (if (null? lst) default
        (let ((get (hashmap-ref (car lst) key unique)))
          (if (eq? get unique)
              (loop (cdr lst))
              get)))))

(define (lexical-scope-stage! scope)
  (define st (lexical-scope-unwrap scope))
  (stack-push! st (make-hashmap))
  (values))

(define (lexical-scope-unstage! scope)
  (define st (lexical-scope-unwrap scope))
  (stack-discard! st)
  (values))
