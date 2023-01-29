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

(cond-expand
 (guile
  (define-module (euphrates profun-op-lambda)
    :export (profun-op-lambda)
    :use-module ((euphrates define-tuple) :select (define-tuple))
    :use-module ((euphrates profun-current-env-p) :select (profun-current-env/p))
    :use-module ((euphrates profun-op) :select (make-profun-op))
    :use-module ((euphrates profun-value) :select (profun-value-unwrap))
    :use-module ((euphrates profun-variable-arity-op-keyword) :select (profun-variable-arity-op-keyword)))))



(define-syntax profun-op-lambda
  (syntax-rules (:with-env)
    ((_ (ctx args args-names) . bodies)
     (profun-op-lambda::without-env
      (ctx args args-names) . bodies))

    ((_ :with-env (ctx args args-names) . bodies)
     (profun-op-lambda
      :with-env env-name/temp
      (ctx args args-names) . bodies))

    ((_ :with-env env-name (ctx args args-names) . bodies)
     (profun-op-lambda::with-env
      env-name (ctx args args-names) . bodies))))

(define-syntax profun-op-lambda::with-env
  (syntax-rules ()
    ((_ env-name (ctx args args-names) . bodies)
     (profun-op-lambda::generic
      (ctx args args-names)
      get-func
      (let ((env-name (compose profun-value-unwrap get-func)))
        (parameterize ((profun-current-env/p env-name))
          (let () . bodies)))))))

(define-syntax profun-op-lambda::without-env
  (syntax-rules ()
    ((_ (ctx args args-names) . bodies)
     (profun-op-lambda::generic
      (ctx args args-names)
      get-func
      (let () . bodies)))))

(define-syntax profun-op-lambda::generic
  (syntax-rules ()
    ((_ (ctx args args-names) get-func cont)
     (make-profun-op
      (profun-op-lambda::get-argn args)
      (lambda (get-func ctx var-names)
        (define-tuple args-names var-names)
        (define vars
          (map get-func var-names))
        (define-tuple args
          (map profun-value-unwrap vars))
        cont)))))

(define-syntax profun-op-lambda::get-argn
  (syntax-rules ()
    ((_ args)
     (let ((qargs (quote args)))
       (if (pair? qargs)
           (length qargs)
           profun-variable-arity-op-keyword)))))
