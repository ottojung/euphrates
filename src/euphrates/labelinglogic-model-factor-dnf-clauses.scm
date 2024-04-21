;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:factor-dnf-clauses model)
  (define (predicate expr)
    (define type (labelinglogic:expression:type expr))
    (cond
     ((member type (list 'or 'variable)) #f)
     ((member type (list 'and 'not 'xor 'tuple 'r7rs 'constant)) #t)
     (else
      (raisu* :from "labelinglogic:model:factor-dnf-clauses"
              :type 'unknown-expr-type
              :message (stringf "Expression type ~s not recognized"
                                (~a type))
              :args (list type expr)))))

  (labelinglogic:model:factor-subexpressions predicate model))
