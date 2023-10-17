;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:factor-out-ors model)
  (define stack (stack-make))

  (define (loop-expr expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (cond
     ((equal? 'constant type) expr)
     (else
      (let ()
        (define alias (make-unique-identifier))

        (stack-push!
         stack
         (list alias expr))

        alias))))

  (define (factor-out-expr expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (cond
     ((equal? 'or type)
      (cons 'or (map loop-expr args)))

     (expr)))

  (define maped-model
    (map
     (lambda (model-component)
       (define-tuple (class predicate) model-component)
       (list class (factor-out-expr predicate)))
     model))

  (define complete-model
    (append
     maped-model
     (reverse
      (stack->list stack))))

  complete-model)
