;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:inline-non-bindings model bindings)
  (define (inline-vars model)
    (labelinglogic:model:map-subexpressions
     (lambda (class predicate)
       (lambda (expr)
         (debugs expr)
         (define type (labelinglogic:expression:type expr))
         (define args (labelinglogic:expression:args expr))
         (if (equal? type 'constant)
             (labelinglogic:model:assoc expr model)
             expr)))

     model))

  (apply-until-fixpoint inline-vars model))
