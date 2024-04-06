;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:factor-dnf-clauses model)
  (define H (make-hashmap))

  (define _766414
    (labelinglogic:model:foreach-expression
     (lambda (class predicate)
       (lambda (expr)
         (define type (labelinglogic:expression:type expr))
         (hashmap-set! H class class)
         (unless (equal? 'or type)
           (unless (hashmap-has? H predicate)
             (hashmap-set! H predicate class)))))

     model))

  (define new-bindings-stack
    (stack-make))

  (define (replace-single maybe-name expr)
    (define existing (hashmap-ref H expr #f))
    (cond
     ((not existing) expr)
     ((equal? existing maybe-name) expr)
     (else existing)))

  (define replaced-model
    (labelinglogic:model:map-expressions
     (lambda (name predicate)
       (lambda (expr)
         (define type (labelinglogic:expression:type expr))
         (define args (labelinglogic:expression:args expr))

         (cond
          ((member type (list 'or 'tuple))
           (let ()
             (define new-clauses
               (map
                (lambda (clause)
                  (define existing (hashmap-ref H clause #f))
                  (or existing
                      (let ()
                        (define name
                          (make-unique-identifier))
                        (define binding
                          (labelinglogic:binding:make name clause))

                        (stack-push! new-bindings-stack binding)
                        (hashmap-set! H clause name)
                        name)))
                args))

             (labelinglogic:expression:make type new-clauses)))

          (else
           (replace-single name expr)))))

     model))

  (define factored-model-1
    (labelinglogic:model:append
     replaced-model
     (reverse
      (stack->list new-bindings-stack))))

  (define factored-model-2
    (labelinglogic:model:map-expressions
     (lambda (clause predicate)
       (lambda (expr)
         (define type (labelinglogic:expression:type expr))
         (define args (labelinglogic:expression:args expr))

         (cond
          ((equal? type 'tuple)
           (labelinglogic:expression:make
            type (map (comp (replace-single #f)) args)))

          (else
           expr))))

     factored-model-1))

  factored-model-2)
