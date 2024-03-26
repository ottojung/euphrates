;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:collect-dnf-r7rs-clauses model)
  (define ret (stack-make))

  (labelinglogic:model:foreach-expression
   (lambda _
     (lambda (expr)
       (define type (labelinglogic:expression:type expr))
       (define args (labelinglogic:expression:args expr))

       (define terms
         (if (equal? 'or type) args (list expr)))

       (define clauses
         (filter labelinglogic:expression:dnf-r7rs-clause? terms))

       (for-each
        (lambda (nic) (stack-push! ret nic))
        clauses)))

   model)

  (stack->list ret))
