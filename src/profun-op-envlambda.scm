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

%var profun-op-envlambda

%use (define-tuple) "./define-tuple.scm"
%use (profun-op-envlambda/p) "./profun-op-envlambda-p.scm"
%use (make-profun-op) "./profun-op.scm"
%use (profun-value-unwrap) "./profun-value.scm"
%use (profun-variable-arity-op-keyword) "./profun-variable-arity-op-keyword.scm"

(define-syntax profun-op-envlambda
  (syntax-rules ()
    ((_ (ctx env args-names) . bodies)
     (make-profun-op
      (let ((qargs (quote args-names)))
        (if (pair? qargs)
            (length qargs)
            profun-variable-arity-op-keyword))
      (lambda (get-func ctx var-names)
        (define-tuple args-names var-names)
        (define env (compose profun-value-unwrap get-func))
        (parameterize ((profun-op-envlambda/p env))
          (let () . bodies)))))))
