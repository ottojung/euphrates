;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:init
         model bindings)

  (define most-default-class #f)

  (labelinglogic:model:check model)

  (define classes/s
    (list->hashset
     (map car model)))

  (labelinglogic:bindings:check classes/s bindings)

  (define (binding:type binding)
    (define expr
      (labelinglogic:binding:expr binding))

    (labelinglogic:expression:type expr))

  (define (class-expr:target expr)
    (list-ref expr 1))

  (define (class-binding:target binding)
    (define expr
      (labelinglogic:binding:expr binding))

    (class-expr:target expr))

  (define bindings-found
    (list->hashset (map labelinglogic:binding:name bindings)))

  (define (is-binding? x)
    (hashset-has? bindings-found x))

  (define classes-bound
    (let ((S (make-hashset)))
      (for-each
       (lambda (binding)
         (define name
           (labelinglogic:binding:name binding))
         (define expr
           (labelinglogic:binding:expr binding))

         (let loop ((expr expr))
           (define type
             (labelinglogic:expression:type expr))
           (define args
             (labelinglogic:expression:args expr))

           (cond
            ((equal? type 'constant)
             (hashset-add! S expr))

            ((equal? type '=)
             'pass)

            ((member type (list 'or 'and 'seq))
             (for-each loop args))

            (else
             (raisu 'impossible-37163612384)))))
       bindings)
      S))

  (define (class-bound? class)
    (hashset-has? classes-bound class))

  (define bindings/opt
    (map
     (lambda (binding)
       (define name (labelinglogic:binding:name binding))
       (define expr (labelinglogic:binding:expr binding))
       (labelinglogic:binding:make
        name (labelinglogic:expression:optimize expr)))
     bindings))

  (define extended-model
    (labelinglogic:model:extend-with-bindings model bindings/opt))

  (define reachable-model
    (filter
     (lambda (model-component)
       (define-tuple (class predicate) model-component)
       (is-binding? class))
     extended-model))

  (define (bigloop model0)
    (define sugar-model
      (labelinglogic:model:map-expressions
       labelinglogic:expression:sugarify
       model0))

    (define combined-exprs-model
      (labelinglogic:model:map-expressions
       labelinglogic:expression:combine-recursively
       sugar-model))

    (define opt-model
      (labelinglogic:model:map-expressions
       labelinglogic:expression:optimize
       combined-exprs-model))

    (define referenced-model
      (labelinglogic:model:map-subexpressions
       (lambda (o-class o-predicate)
         (lambda (expr)
           (list-map-first
            (lambda (model-component)
              (define-tuple (b-class b-predicate) model-component)
              (and (not (equal? o-class b-class))
                   (is-binding? b-class)
                   (equal? expr b-predicate)
                   b-class))
            expr opt-model)))
       opt-model))

    referenced-model)

  (define opt-model
    (apply-until-fixpoint
     bigloop reachable-model))

  (define flat-model
    (labelinglogic:model:flatten opt-model))

  flat-model)
