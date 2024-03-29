;;;; Copyright (C) 2022, 2023  Otto Jung
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



;; Make sure that `param-name' is unique.

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
             (profun-request-value input-name))))))

(define unique-counter
  (let ((count 0))
    (lambda _
      (set! count (+ 1 count))
      count)))

(define (make-profun-parameter)
  (define param-name (make-usymbol 'p (unique-counter)))
  (define op (profun-op-parameter param-name))

  (define (instantiate) op)

  (define (get)
    (define get-func
      (or (profun-current-env/p)
          (raisu 'could-not-get-environment "Make sure that you are using op-envlambda")))

    (get-func param-name))

  (define (set args)
    (define get-func
      (or (profun-current-env/p)
          (raisu 'could-not-get-environment "Make sure that you are using op-envlambda")))

    (define _1
      (unless (= 2 (length args))
        (raisu 'type-error "Expected two arguments in set operation" args)))

    (define val (car args))
    (define next (cadr args))

    (profun-set (param-name <- val) next))

  (case-lambda
   (() (get))
   ((action . args)
    (case action
      ((get) (get))
      ((set) (set args))
      ((instantiate) (instantiate))
      (else (raisu 'uknown-parameter-action action))))))

(define (instantiate-profun-parameter p)
  (p 'instantiate))
