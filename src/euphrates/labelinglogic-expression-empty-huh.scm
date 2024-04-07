;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:empty? model expr)
  (define expr0 expr)
  (let loop ((expr expr))

    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (cond
     ((equal? type '=) #f)
     ((equal? type 'r7rs) #f)

     ((equal? type 'not)
      (not (loop (car args))))

     ((member type (list 'tuple 'or))
      (list-and-map loop args))

     ((equal? type 'constant)
      (loop (labelinglogic:model:assoc expr model)))

     ((member type (list 'and 'xor))
      (raisu* :from "labelinglogic:expression:empty?"
              :type 'bad-type
              :message (stringf "Expressions of type ~s cannot be determined to be empty."
                                (~a type))
              :args (list type expr expr0)))

     (else
      (raisu* :from "labelinglogic:expression:empty?"
              :type 'unknown-expr-type
              :message (stringf "Expression type ~s not recognized"
                                (~a type))
              :args (list type expr expr0))))))
