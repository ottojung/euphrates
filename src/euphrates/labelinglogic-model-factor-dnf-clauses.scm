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

    (cond
     ((not existing)

      (if #f expr
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
    (labelinglogic:model:map-subexpressions
     (lambda (name predicate)
       (lambda (expr)
         (define type (labelinglogic:expression:type expr))
         (define args (labelinglogic:expression:args expr))
         (define toplevel? (equal? expr predicate))

         (when toplevel?
           (debug "YAAAAAY"))

         (unless toplevel?
           (debugs predicate)
           (debugs expr))

         (replace-single toplevel? name expr)))

     model))

  (define factored-model
    (labelinglogic:model:append
     replaced-model
     (reverse
      (stack->list new-bindings-stack))))

  factored-model)
