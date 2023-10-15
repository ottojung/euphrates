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

  (define generated-names
    (make-hashset))

  (define generate-new-class-name
    (let ((counter 0))
      (lambda _
        (define ret (list 'ref counter))
        (set! counter (+ 1 counter))
        (hashset-add! generated-names ret)
        ret)))

  (define (generated-name? x)
    (hashset-has? generated-names x))

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

         (define new-name (generate-new-class-name))

         (define new-parent
           (list class `(or ,name ,new-name)))

         (define renamed-current
           (list new-name predicate))

         (define added
           (list name expr))

         (list new-parent renamed-current added))

       (cond

        ((equal? 'constant expr:type)
         (apply
          append
          (map
           (lambda (model-component)
             (define-tuple (class predicate) model-component)

             (if (not (equal? class expr))
                 (list model-component)
                 (list binding model-component)))
           model)))

        ((equal? '= expr:type)

         (apply
          append
          (map
           (lambda (model-component)
             (define-tuple (class predicate) model-component)
             (define expr-type
               (labelinglogic:expression:type predicate))

             (cond
              ((equal? expr-type 'r7rs)

               (if (evaluate-predicate predicate (car expr:args))
                   (fork-current model-component)
                   (list model-component)))

              (else
               (list model-component))))

           model)))

        (else
         (raisu 'unknown-expr-type binding))))))

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
     extended-model))

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

  opt-model)
