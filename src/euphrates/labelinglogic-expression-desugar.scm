;;;; Copyright (C) 2023, 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:desugar expr)
  (let loop ((expr expr))

    (define type
      (labelinglogic:expression:type expr))
    (define args
      (labelinglogic:expression:args expr))

    (cond
     ((equal? type 'tuple)
      (labelinglogic:expression:make
       type (map loop args)))

     ((equal? type 'not)
      (labelinglogic:expression:make
       type (map loop args)))

     ((labelinglogic:expression:type:associative? type)
      (if (list-length= 1 args)
          (loop (car args))

          (let ()
            (define linearized
              (map
               loop
               (labelinglogic:expression:args
                (labelinglogic:expression:sugarify expr))))

            (define folded
              (let loop ((rest linearized))
                (cond
                 ((or (null? rest)
                      (null? (cdr rest))
                      (null? (cddr rest)))
                  (labelinglogic:expression:make
                   type rest))
                 (else
                  (labelinglogic:expression:make
                   type (list (car rest) (loop (cdr rest))))))))

            folded)))

     ((member type (list '= 'variable 'r7rs))
      expr)

     (else
      (raisu* :from "labelinglogic:expression:desugar"
              :type 'unknown-expr-type
              :message (stringf "Expression type ~s not recognized"
                                (~a type))
              :args (list type expr))))))
