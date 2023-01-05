;;;; Copyright (C) 2020, 2021, 2022, 2023  Otto Jung
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
%use (profun-current-env/p) "./profun-current-env-p.scm"
%use (make-profun-op) "./profun-op.scm"
%use (profun-value-unwrap) "./profun-value.scm"
%use (profun-variable-arity-op-keyword) "./profun-variable-arity-op-keyword.scm"

(define-syntax profun-op-lambda
  (syntax-rules (:env)
    ((_ (ctx :env env-name args args-names) . bodies)
     (make-profun-op
      (profun-op-lambda::get-argn args)
      (lambda (get-func ctx var-names)
        (define-tuple args-names var-names)
        (define vars
          (map get-func var-names))
        (define-tuple args
          (map profun-value-unwrap vars))
        (define env-name (compose profun-value-unwrap get-func))
        (parameterize ((profun-current-env/p env))
          (let () . bodies)))))
    ((_ (ctx args args-names) . bodies)
     (make-profun-op
      (profun-op-lambda::get-argn args)
      (lambda (get-func ctx var-names)
        (define-tuple args-names var-names)
        (define vars
          (map get-func var-names))
        (define-tuple args
          (map profun-value-unwrap vars))
        (let () . bodies))))))

(define-syntax profun-op-lambda::get-argn
  (syntax-rules ()
    ((_ args)
     (let ((qargs (quote args)))
       (if (pair? qargs)
           (length qargs)
           profun-variable-arity-op-keyword)))))
