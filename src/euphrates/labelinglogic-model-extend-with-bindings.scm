;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:extend-with-bindings model bindings)
  (define bindings-set
    (list->hashset
     (map labelinglogic:binding:name bindings)))

  (define (is-binding? name)
    (hashset-has? bindings-set name))

  (define renamings
    (let ()
      (define H (make-hashmap))
      (for-each
       (lambda (model-component)
         (define-tuple (class predicate) model-component)
         (define type (labelinglogic:expression:type predicate))
         (define existing (hashmap-ref H predicate #f))

         (when existing
           (raisu* :from "labelinglogic:model:extend-with-bindings"
                   :type 'duplicated-token
                   :message (stringf "Two names ~s for the same expression ~s"
                                     (list existing class) (list predicate))
                   :args (list class predicate existing)))

         (when (equal? type 'constant)
           (hashmap-set! H predicate class)))
       bindings)
      H))

  (define replaced-model
    (labelinglogic:model:replace-constants
     (lambda (class)
       (lambda (constant)
         (define renamed
           (hashmap-ref renamings constant #f))
         (if (and renamed (not (equal? renamed class)))
             renamed
             constant ;; in the renaming thingy
             )))
     model))

  (define extended-model
    (append replaced-model bindings))

  (define initial-names-set
    (list->hashset
     (map labelinglogic:binding:name extended-model)))

  (define (is-initial-name? name)
    (hashset-has? bindings-set name))

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
            (list '= 'constant 'or 'and 'tuple 'not 'r7rs))

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
    (define (replacer class)
      (lambda (constant)
        (if (is-binding? constant)
            constant
            (let ()
              (define target-component (assoc constant model))
              (define-tuple (target-class target-predicate) target-component)
              target-predicate))))

    (labelinglogic:model:replace-constants
     replacer model))

  (define transitive-model
    (apply-until-fixpoint
     connect-transitive-model-edges
     duplicated-model))

  (define reduced-model
    (filter
     (lambda (model-component)
       (define-tuple (class predicate) model-component)
       (is-initial-name? class))
     transitive-model))

  reduced-model)
