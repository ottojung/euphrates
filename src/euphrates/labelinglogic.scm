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

         (define type
           (labelinglogic:expression:type expr))

         (cond
          ((equal? type 'constant)
           (hashset-add! S expr))

          ((equal? type '=)
           'pass)

          (else
           (raisu 'impossible-37163612384))))
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

  (define extended-model
    (list-fold
     (model renamed-model)
     (binding bindings)

     (let ()
       (define-tuple (name expr) binding)
       (define expr:type (labelinglogic:expression:type expr))
       (define expr:args (labelinglogic:expression:args expr))

       (define (fork-current model-component)
         (define-tuple (class predicate) model-component)

         (define new-name (make-unique-identifier))

         (define new-parent
           (list class `(or ,name ,new-name)))

         (define renamed-current
           (list new-name predicate))

         (list new-parent renamed-current))

       (cond

        ((equal? '= expr:type)

         (let ()
           (define leafs (labelinglogic:model:reduce-to-leafs model))
           (define desc (labelinglogic:make-nondet-descriminator leafs))
           (define containing-classes
             (list->hashset (desc (car expr:args))))

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

        ((equal? 'constant expr:type) model)

        (else
         (raisu 'unknown-expr-type binding))))))

  (define combined-model
    (append extended-model bindings))

  (define (connect-transitive-model-edges model)
    (map
     (lambda (model-component)
       (define-tuple (class predicate) model-component)

       (define (replacer constant)
         (if (is-binding? constant)
             constant
             (let ()
               (define target-component (assoc constant model))
               (define-tuple (target-class target-predicate) target-component)
               target-predicate)))

       (list
        class
        (labelinglogic:expression:replace-constants predicate replacer)))

     model))

  (define transitive-model
    (apply-until-fixpoint
     connect-transitive-model-edges
     combined-model))

  (define reachable-model
    (filter
     (lambda (model-component)
       (define-tuple (class predicate) model-component)
       (is-binding? class))
     transitive-model))

  (define sugar-model
    (map
     (lambda (model-component)
       (define-tuple (class predicate) model-component)
       (list class (labelinglogic:expression:sugarify predicate)))
     reachable-model))

  (define combined-exprs-model
    (map
     (lambda (model-component)
       (define-tuple (class predicate) model-component)
       (list class (labelinglogic:expression:combine-recursively predicate)))
     sugar-model))

  (define opt-model
    (map
     (lambda (model-component)
       (define-tuple (class predicate) model-component)
       (list class (labelinglogic:expression:optimize predicate)))
     combined-exprs-model))

  (define flat-model
    (labelinglogic:model:factor-out-ors opt-model))

  flat-model)
