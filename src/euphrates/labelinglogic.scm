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

  (define (evaluate-predicate predicate arg)
    (define code (cadr predicate))
    (eval (list code arg)
          (environment '(scheme base) '(scheme char))))

  (define class->binding/h
    (let ()
      (define H (make-hashmap))
      (for-each
       (lambda (binding)
         (define name (labelinglogic:binding:name binding))
         (define expr (labelinglogic:binding:expr binding))
         (define type (labelinglogic:expression:type expr))

         (when (equal? type 'constant)
           (hashmap-set! H expr name)))

       bindings)
      H))

  (define (class->binding class)
    (hashmap-ref class->binding/h class #f))

  (define desugared-model
    (map
     (lambda (model-component)
       (define-tuple (class predicate) model-component)
       (list class (labelinglogic:expression:desugar predicate)))

     model))

  (define renamed-model
    (map
     (lambda (model-component)
       (define-tuple (class predicate) model-component)

       (define (replacer constant)
         (or (class->binding constant) constant))

       (list
        class
        (labelinglogic:expression:replace-constants predicate replacer)))

     desugared-model))

  (define bindings/opt
    (map
     (lambda (binding)
       (define name (labelinglogic:binding:name binding))
       (define expr (labelinglogic:binding:expr binding))
       (labelinglogic:binding:make
        name (labelinglogic:expression:optimize expr)))
     bindings))

  (define extended-model
    (append renamed-model
            bindings/opt))

  (define duplicated-model
    (list-fold
     (model extended-model)
     (binding extended-model)

     (let ()
       (define-tuple (name expr) binding)
       (define expr:type (labelinglogic:expression:type expr))
       (define expr:args (labelinglogic:expression:args expr))

       (define (fork-current model-component)
         (define-tuple (class predicate) model-component)

         (if (equal? class name)
             (list model-component)
             (let ()

               (define new-name (make-unique-identifier))

               (define new-parent
                 (list class `(or ,name ,new-name)))

               (define renamed-current
                 (list new-name predicate))

               (list new-parent renamed-current))))

       (define (try-to-add inputs)
         (define leafs (labelinglogic:model:reduce-to-leafs model))
         (define desc (labelinglogic:make-nondet-descriminator leafs))
         (define containing-classes
           (list->hashset
            (list-fold/semigroup
             list-intersect/order-independent
             (map desc inputs))))

         (if (null? containing-classes) '()
             (apply
              append
              (map
               (lambda (model-component)
                 (define-tuple (class predicate) model-component)

                 (cond
                  ((hashset-has? containing-classes class)
                   (fork-current model-component))

                  (else
                   (list model-component))))

               model))))

       (if (member
            expr:type
            (list '= 'constant 'or 'and 'seq 'r7rs))

           (let ()
             (define biggest-universe
               (catchu-case
                (labelinglogic:model:calculate-biggest-universe model expr)

                (('no-biggest-universe . args) '())))

             (if (null? biggest-universe) model
                 (try-to-add biggest-universe)))

           (raisu* :from "labelinglogic"
                   :type 'unknown-expr-type
                   :message (stringf "Expression type ~s not recognized"
                                     (~a expr:type))
                   :args (list expr:type binding))))))

  (define (connect-transitive-model-edges model)
    (define (replacer constant)
      (if (is-binding? constant)
          constant
          (let ()
            (define target-component (assoc constant model))
            (define-tuple (target-class target-predicate) target-component)
            target-predicate)))

    (labelinglogic:expression:replace-constants
     model replacer))

  (define transitive-model
    (apply-until-fixpoint
     connect-transitive-model-edges
     duplicated-model))

  (define reachable-model
    (filter
     (lambda (model-component)
       (define-tuple (class predicate) model-component)
       (is-binding? class))
     transitive-model))

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
