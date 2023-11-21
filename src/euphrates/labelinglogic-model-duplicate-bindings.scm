;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:duplicate-bindings model bindings)
  (define bindings-set
    (list->hashset
     (map labelinglogic:binding:name bindings)))

  (define (is-binding? name)
    (hashset-has? bindings-set name))

  (debugs model)

  ;; (define duplicated-model
  ;;   (list-fold
  ;;    (model model)
  ;;    (binding model)

  ;;    (let ()
  ;;      (define-tuple (name expr) binding)
  ;;      (define expr:type (labelinglogic:expression:type expr))
  ;;      (define expr:args (labelinglogic:expression:args expr))

  ;;      (define (fork-current model-component new-expr)
  ;;        (define-tuple (class predicate) model-component)

  ;;        (if (equal? class name)
  ;;            (list model-component)
  ;;            (list (labelinglogic:binding:make class new-expr))))

  ;;      (define (try-to-add inputs)
  ;;        ;; (define leafs (labelinglogic:model:reduce-to-leafs model))
  ;;        (define desc (labelinglogic:make-nondet-descriminator model))
  ;;        (define containing-classes
  ;;          (list->hashset
  ;;           (list-fold/semigroup
  ;;            list-intersect/order-independent
  ;;            (map desc inputs))))

  ;;        (if (null? containing-classes) '()
  ;;            (apply
  ;;             append
  ;;             (map
  ;;              (lambda (model-component)
  ;;                (define-tuple (class predicate) model-component)
  ;;                (define type (labelinglogic:expression:type predicate))
  ;;                (define args (labelinglogic:expression:args predicate))
  ;;                (define new-args
  ;;                  (if (equal? type 'or)
  ;;                      (append args (list name))
  ;;                      (list predicate name)))
  ;;                (define new-expr
  ;;                  (labelinglogic:expression:make
  ;;                   'or new-args))

  ;;                (cond
  ;;                 ((hashset-has? containing-classes class)
  ;;                  (fork-current model-component new-expr))

  ;;                 (else
  ;;                  (list model-component))))

  ;;              model))))

  ;;      ;; FIXME: REMOVE
  ;;      (if (member
  ;;           expr:type
  ;;           (list '= 'constant 'or 'and 'tuple 'not 'xor 'r7rs))

  ;;          (let ()
  ;;            (define biggest-universe
  ;;              (catchu-case
  ;;               (labelinglogic:model:calculate-biggest-universe model expr)

  ;;               (('no-biggest-universe . args) '())))

  ;;            (debugs binding)
  ;;            (debugs biggest-universe)

  ;;            (if (null? biggest-universe) model
  ;;                (try-to-add biggest-universe)))

  ;;          (raisu* :from "labelinglogic"
  ;;                  :type 'unknown-expr-type
  ;;                  :message (stringf "Expression type ~s not recognized"
  ;;                                    (~a expr:type))
  ;;                  :args (list expr:type binding))))))

  (define to-duplicate
    (let ()
      (define S (make-hashset))
      (labelinglogic:model:map-subexpressions
       (const
        (lambda (expr)
          (define type (labelinglogic:expression:type expr))
          (define args (labelinglogic:expression:args expr))
          (when (equal? type '=)
            (hashset-add! S (car args)))
          expr))
       model)
      (hashset->list S)))

  (define (mapper expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (list-fold
     (acc expr)
     (binding to-duplicate)

     (cond
      ((and (equal? type 'r7rs)
            (labelinglogic:expression:evaluate/r7rs expr binding)


  (define duplicated-model
    (labelinglogic:model:map-subexpressions
     (const mapper)
     model))

  (debugs duplicated-model)

  duplicated-model)
