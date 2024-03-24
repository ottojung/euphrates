;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:equal?/syntactic/order-independent
         expr-1 expr-2)

  (let loop ((expr-1 expr-1)
             (expr-2 expr-2))

    (define type-1 (labelinglogic:expression:type expr-1))
    (define type-2 (labelinglogic:expression:type expr-2))
    (define args-1 (labelinglogic:expression:args expr-1))
    (define args-2 (labelinglogic:expression:args expr-2))

    (and
     (equal? type-1 type-2)

     (cond
      ((labelinglogic:expression:ground? expr-1)
       (labelinglogic:expression:syntactic-equal? expr-1 expr-2))

      ((member type-1 (list 'or 'and 'xor 'not 'tuple 'r7rs '=))
       (and (= (length args-1) (length args-2))
            (list-and-map loop args-1 args-2)))

      ((equal? type-1 'constant)
       (raisu* :from "labelinglogic:expression:equal?/syntactic/order-independent"
               :type 'bad-sub-expr-type
               :message (stringf "Expression type ~s not permitted here." (~a type-small))
               :args (list expr-1 expr-2)))

      (else
       (raisu* :from "labelinglogic:expression:equal?/syntactic/order-independent"
               :type 'unknown-expr-type
               :message (stringf "Expression type ~s not recognized"
                                 (~a type))
               :args (list type-1 expr-1 expr-2)))))))
