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



;; Does not evaluate its arguments until requested.
;; To be used with `with-dynamic' and `with-dynamic-set!'.

(define-syntax lazy-parameter
  (syntax-rules ()
    ((_ initial)
     (let ((p (make-parameter (memconst initial))))
       (case-lambda
        (() ((p)))
        ((func) (p (memconst (func))))
        ((func body)
         (parameterize ((p (memconst (func))))
           (body))))))
    ((_ initial converter)
     (let ((p (make-parameter (memconst initial))))
       (case-lambda
        (() ((p)))
        ((func) (p (memconst (converter (func)))))
        ((func body)
         (parameterize ((p (memconst (converter (func)))))
           (body))))))))

