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

%var profun-op-lambda

%use (define-tuple) "./define-tuple.scm"
%use (profun-op) "./profun-op.scm"
%use (profun-value-name profun-value-unwrap) "./profun-value.scm"
%use (profun-variable-arity-op-keyword) "./profun-variable-arity-op-keyword.scm"

(define-syntax profun-op-lambda
  (syntax-rules ()
    ((_ (ctx args args-names) . bodies)
     (profun-op
      (let ((qargs (quote args)))
        (if (pair? qargs)
            (length qargs)
            profun-variable-arity-op-keyword))
      (lambda (vars ctx)
        (define-tuple args
          (map profun-value-unwrap vars))
        (define-tuple args-names
          (map profun-value-name vars))
        (let () . bodies))))))
