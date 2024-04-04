;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:factor-dnf-clauses model)
  (define H (make-hashmap))

  (labelinglogic:model:foreach-expression
   (lambda (class predicate)
     (lambda (expr)
       (define type (labelinglogic:expression:type expr))
       (unless (equal? 'or type)
         (hashmap-set! H predicate class))))

   model)

  (define new-bindings-stack
    (stack-make))

  (define replaced-model
    (labelinglogic:model:map-expressions
     (lambda _
       (lambda (expr)
         (define type (labelinglogic:expression:type expr))
         (define args (labelinglogic:expression:args expr))

         (define clauses
           (if (equal? 'or type) args (list expr)))

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
                    (hashmap-set! H binding name))))
            clauses))

         (map
          (lambda (nic) (stack-push! ret nic))
          clauses)))

     model))

  new-model)
