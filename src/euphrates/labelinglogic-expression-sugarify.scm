;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:sugarify/functor expr)
  (define type0 (labelinglogic:expression:type expr))
  (define stack (stack-make))

  (let loop ((expr expr))
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (cond
     ((equal? type type0) (for-each loop args))
     (else (stack-push! stack expr))))

  (define linearized
    (reverse (stack->list stack)))

  (labelinglogic:expression:make
   type0 linearized))

(define (labelinglogic:expression:sugarify/unwrap expr)
  (define type (labelinglogic:expression:type expr))
  (define args (labelinglogic:expression:args expr))

  (if (list-length= 1 args)
      (car args)
      expr))

(define (labelinglogic:expression:sugarify/children expr)
  (define type (labelinglogic:expression:type expr))
  (define args (labelinglogic:expression:args expr))

  (debugs expr)
  (debugs args)

  (cond
   ((member type (list 'tuple 'and 'or 'not 'xor))
    (debugs "HERE!!!")
    (labelinglogic:expression:make
     type (map labelinglogic:expression:sugarify args)))

   ((member type (list '= 'constant 'r7rs))
    expr)

   (else
    (raisu* :from "labelinglogic:expression:sugarify"
            :type 'unknown-expr-type
            :message (stringf "Expression type ~s not recognized"
                              (~a type))
            :args (list type expr)))))


(define (labelinglogic:expression:sugarify expr)
  (define type (labelinglogic:expression:type expr))
  (define args (labelinglogic:expression:args expr))

  (cond
   ((labelinglogic:expression:type:associative? type)
    (labelinglogic:expression:sugarify/unwrap
     (labelinglogic:expression:sugarify/children
      (labelinglogic:expression:sugarify/functor expr))))

   ((equal? type 'tuple)
    (labelinglogic:expression:sugarify/unwrap
     (labelinglogic:expression:sugarify/children expr)))

   ((member type (list '= 'constant 'r7rs)) expr)

   (else
    (raisu* :from "labelinglogic:expression:sugarify"
            :type 'unknown-expr-type
            :message (stringf "Expression type ~s not recognized"
                              (~a type))
            :args (list type expr)))))
