;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:deduplicate-subexpressions model)
  (define H (make-hashmap))
  (define original-names
    (list->hashset
     (labelinglogic:model:names model)))

  (define (cycle model)
    (define _766414
      (labelinglogic:model:foreach-expression
       (lambda (class predicate)
         (lambda (expr)
           (define type (labelinglogic:expression:type expr))
           (hashmap-set! H class class)
           (unless (hashmap-has? H predicate)
             (hashmap-set! H predicate class))))

       model))

    (define S (make-multiset))

    (define _172371
      (labelinglogic:model:foreach-subexpression
       (lambda (class predicate)
         (lambda (expr) (multiset-add! S expr)))
       model))

    (define new-bindings-stack
      (stack-make))

    (define _127371273
      (multiset-foreach/key-value
       (lambda (key value)
         (when (< 1 value)
           (unless (hashmap-has? H key)
             (let ()
               (define name
                 (make-unique-identifier))
               (define binding
                 (labelinglogic:binding:make name key))

            (stack-push! new-bindings-stack binding)
            (hashmap-set! H key name)))))
       S))

    (define unchanged? #t)

    (define replaced-model
      (labelinglogic:model:map-subexpressions
       (lambda (class predicate)
         (lambda (expr)
           (define existing
             (hashmap-ref H expr #f))

           (cond
            ((not existing) expr)
            ((equal? class existing) expr)
            ((eq? expr existing) expr)
            (else
             (set! unchanged? #f)
             existing))))

       model))

    (if unchanged? #f
        (let ()
          (define combined-model
            (labelinglogic:model:append
             replaced-model
             (reverse
              (stack->list new-bindings-stack))))

          combined-model)))

  (define looped
    (let loop ((model model))
      (define new (cycle model))
      (if new (loop new) model)))

  (define reduced
    (labelinglogic:model:reduce-to-names
     original-names looped))

  reduced)
