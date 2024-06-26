;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:factor-subexpressions predicate model)
  (define bindings (stack-make))

  (define replaced-model
    (labelinglogic:model:map-expressions
     (lambda (class expr)
       (lambda (expr)
         (define-values (new-expr new-bindings)
           (labelinglogic:expression:factor-subexpressions
            predicate expr))
         (for-each (comp (stack-push! bindings)) new-bindings)
         new-expr))
     model))

  (define combined
    (labelinglogic:model:append
     replaced-model
     (reverse
      (stack->list bindings))))

  combined)

