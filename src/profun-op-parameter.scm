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

%var make-profun-parameter
%var instantiate-profun-parameter

;; Make sure that `param-name' is unique.
%use (bool->profun-result) "./bool-to-profun-result.scm"
%use (make-profun-RFC) "./profun-RFC.scm"
%use (profun-set) "./profun-accept.scm"
%use (profun-op-envlambda/p) "./profun-op-envlambda-p.scm"
%use (make-profun-op) "./profun-op.scm"
%use (profun-bound-value? profun-value-unwrap) "./profun-value.scm"
%use (raisu) "./raisu.scm"
%use (make-usymbol) "./usymbol.scm"

(define (profun-op-parameter param-name)
  (make-profun-op
   1
   (lambda (get-func ctx var-names)
     (define input-name
       (if (= 1 (length var-names))
           (car var-names)
           (raisu 'got-a-bad-number-of-vars var-names)))
     (define input (profun-value-unwrap (get-func input-name)))
     (define param (profun-value-unwrap (get-func param-name)))

     (if (profun-bound-value? input)
         (if (profun-bound-value? param)
             (bool->profun-result
              (equal? input param))
             (profun-set (param-name <- input)))
         (if (profun-bound-value? param)
             (profun-set (input-name <- param))
             (make-profun-RFC `((value ,input-name))))))))

(define (make-profun-parameter)
  (define param-name (make-usymbol 'p (gensym)))
  (define op (profun-op-parameter param-name))

  (define (instantiate)
    op)

  (define (get)
    (define get-func
      (or (profun-op-envlambda/p)
          (raisu 'could-not-get-environment "Make sure that you are using op-envlambda")))

    (profun-value-unwrap (get-func param-name)))

  (case-lambda
   (() (get))
   ((action)
    (case action
      ((get) (get))
      ((instantiate) (instantiate))
      (else (raisu 'uknown-parameter-action action))))))

(define (instantiate-profun-parameter p)
  (p 'instantiate))
