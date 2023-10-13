;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic::init
         model bindings)

  (define most-default-class #f)

  (labelinglogic::model:check most-default-class model)

  (define classes/s
    (list->hashset
     (map car model)))

  (labelinglogic::bindings:check classes/s bindings)

  (define (binding:type binding)
    (define expr
      (labelinglogic::binding:expr binding))

    (labelinglogic::expression:type expr))

  (define (class-expr:target expr)
    (list-ref expr 1))

  (define (class-binding:target binding)
    (define expr
      (labelinglogic::binding:expr binding))

    (class-expr:target expr))

  (define bindings-found
    (list->hashset (map labelinglogic::binding:name bindings)))

  (define (is-binding? x)
    (hashset-has? bindings-found x))

  (define classes-bound
    (let ((S (make-hashset)))
      (for-each
       (lambda (binding)
         (define name
           (labelinglogic::binding:name binding))

         (define type
           (binding:type binding))

         (cond
          ((equal? type 'class)
           (let ((target (class-binding:target binding)))
             (hashset-add! S target)))

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
        (define ret (list 'class counter))
        (set! counter (+ 1 counter))
        (hashset-add! generated-names ret)
        ret)))

  (define (generated-name? x)
    (hashset-has? generated-names x))

  (define (evaluate-predicate predicate arg)
    (define code (cadr predicate))
    (eval (list code arg)
          (environment '(scheme base) '(scheme char))))

  (define extended-model
    (list-fold
     (model model)
     (binding bindings)

     (let ()
       (define-tuple (name expr) binding)
       (define-tuple (labelinglogic::expression:type expr:value) expr)

       (cond

        ((equal? 'class labelinglogic::expression:type)
         (apply
          append
          (map
           (lambda (model-component)
             (define-tuple (class predicate superclass) model-component)

             (if (not (equal? class expr:value))
                 (list model-component)
                 (let ()
                   (define added
                     (list name 'union superclass))

                   (define renamed-current
                     (list class predicate name))

                   (list added renamed-current))))
           model)))

        ((equal? '= labelinglogic::expression:type)

         (apply
          append
          (map
           (lambda (model-component)
             (define-tuple (class predicate superclass) model-component)

             (cond
              ((equal? 'union predicate)
               (list model-component))

              ((and (list? predicate)
                    (list-length= 2 predicate)
                    (equal? (car predicate) 'r7rs))

               (if (evaluate-predicate predicate expr:value)
                   (let ()
                     (define new-parent
                       (list class 'union superclass))

                     (define renamed-current
                       (list (generate-new-class-name) predicate class))

                     (define added
                       (list name (list '= expr:value) class))

                     (list new-parent renamed-current added))
                   (list model-component)))

              ((and (pair? predicate)
                    (equal? '= (car predicate)))
               (list model-component))

              (else
               (raisu 'unknown-model-component-type-2 model-component))))
           model)))

        (else
         (raisu 'unknown-expr-type binding))))))

  (define (connect-transitive-model-edges model)
    (map
     (lambda (model-component)
       (define-tuple (class predicate superclass) model-component)

       (if (or (equal? most-default-class superclass)
               (is-binding? superclass))
           model-component
           (let ()
             (define superclass-component (assq superclass model))
             (define-tuple (superclass:class superclass:predicate superclass:superclass) superclass-component)
             (list class predicate superclass:superclass))))
     model))

  (define transitive-model
    (apply-until-fixpoint
     connect-transitive-model-edges
     extended-model))

  (define (remove-empty-unions model)
    (filter
     (lambda (model-component)
       (define-tuple (class predicate superclass) model-component)
       (or (not (equal? 'union predicate))
           (let ()
             (define has-child?
               (list-or-map
                (lambda (child-model-component)
                  (define-tuple (child-class child-predicate child-superclass) child-model-component)
                  (equal? child-superclass class))
                model))

             has-child?)))
     model))

  (define non-empty-model
    (apply-until-fixpoint
     remove-empty-unions
     transitive-model))

  (define found-superclasss
    (list->hashset
     (map
      (lambda (model-component)
        (define-tuple (class predicate superclass) model-component)
        superclass)
      transitive-model)))

  (define (superclass-found? x)
    (hashset-has? found-superclasss x))

  (define reachability-roots
    (hashset->list bindings-found))

  (define reachable-model
    (filter
     (lambda (model-component)
       (define-tuple (class predicate superclass) model-component)
       (or (is-binding? class)
           (is-binding? superclass)))
     non-empty-model))

  reachable-model)
