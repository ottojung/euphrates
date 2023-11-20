;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:sugarify/functor expr)
  (define type0 (labelinglogic:expression:type expr))
  (define stack (stack-make))

  (let loop ((expr expr))

    (define type
      (labelinglogic:expression:type expr))

    (define args
      (labelinglogic:expression:args expr))

    (cond
     ((equal? type type0) (for-each loop args))
     (else
      (stack-push!
       stack

       (if (labelinglogic:expression:type:associative? type)
           (labelinglogic:expression:sugarify expr)
           expr)))))

  (define linearized
    (reverse (stack->list stack)))

  (labelinglogic:expression:make
   type0 linearized))

(define (labelinglogic:expression:sugarify/unwrap expr)
  (define args (labelinglogic:expression:args expr))
  (if (list-length= 1 args)
      (labelinglogic:expression:sugarify (car args))
      (labelinglogic:expression:make
       type (map labelinglogic:expression:sugarify args))))

(define (labelinglogic:expression:sugarify expr)
  (define type (labelinglogic:expression:type expr))
  (define args (labelinglogic:expression:args expr))

  (cond
   ((equal? type 'tuple)
    (if (list-length= 1 args)
        (labelinglogic:expression:sugarify (car args))
        (labelinglogic:expression:make
         type (map labelinglogic:expression:sugarify args))))

   ((labelinglogic:expression:type:associative? type)
    (labelinglogic:expression:sugarify/functor expr))

   ((member type (list '= 'constant 'r7rs)) expr)

   (else
    (raisu* :from "labelinglogic:expression:sugarify"
            :type 'unknown-expr-type
            :message (stringf "Expression type ~s not recognized"
                              (~a type))
            :args (list type expr)))))
