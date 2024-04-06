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
         (unless (hashmap-has? H predicate)
           (hashmap-set! H predicate class))))

     model))

  (define new-bindings-stack
    (stack-make))

  (define (replace-single toplevel? maybe-name expr)
    (define existing (hashmap-ref H expr #f))

    (debugs expr)
    (debugs existing)

    (cond
     ((not existing)

      (if toplevel? expr
          (let ()
            (define name
              (make-unique-identifier))
            (define binding
              (labelinglogic:binding:make name expr))

            (stack-push! new-bindings-stack binding)
            (hashmap-set! H expr name)
            name)))

     ((equal? existing maybe-name) expr)
     (else existing)))

  (define replaced-model
    (labelinglogic:model:map-expressions
     (lambda (name predicate)
       (lambda (predicate)
         (define type (labelinglogic:expression:type predicate))
         (define args (labelinglogic:expression:args predicate))

         (define (inner expr)
           (labelinglogic:expression:map-subexpressions
            (lambda (expr) (replace-single #f name expr))
            expr))

         (define new-args
           (if (labelinglogic:expression:ground? predicate)
               args
               (map inner args)))
         (define new-predicate (labelinglogic:expression:make type new-args))
         (replace-single #t name new-predicate)))

     model))

  (define factored-model
    (labelinglogic:model:append
     replaced-model
     (reverse
      (stack->list new-bindings-stack))))

  factored-model)
