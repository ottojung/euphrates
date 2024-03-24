;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:optimize/singletons expr)
  (let loop ((expr expr))
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (cond
     ((member type (list 'or 'and 'xor 'tuple))
      (let ()
        (define args*
          (map loop (labelinglogic:expression:args expr)))

        (if (list-singleton? args*)
            (car args*)
            (labelinglogic:expression:make type args*))))

     ((equal? type 'not)
      (labelinglogic:expression:make
       type (map loop args)))

     ((member type (list 'constant '= 'r7rs)) expr)

     (else
      (raisu* :from "labelinglogic:expression:optimize/singleton"
              :type 'unknown-expr-type
              :message (stringf "Expression type ~s not recognized"
                                (~a type))
              :args (list type expr))))))
