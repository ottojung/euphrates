;;;; Copyright (C) 2024, 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:collect-dnf-clauses model)
  (define ret (stack-make))

  (labelinglogic:model:foreach-expression
   (lambda _
     (lambda (expr)
       (define type (labelinglogic:expression:type expr))
       (define args (labelinglogic:expression:args expr))

       (define clauses
         (if (equal? 'or type) args (list expr)))

       (for-each
        (lambda (nic) (stack-push! ret nic))
        clauses)))

   model)

  (reverse
   (stack->list ret)))
