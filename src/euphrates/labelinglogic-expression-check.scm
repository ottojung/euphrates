;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:check x)
  (define (fail-expression-check show args)
    (raisu* :from "labelinglogic:expression:check"
            :type 'expression-type-error
            :message (stringf "Type error: ~a." show)
            :args args))

  (unless (or (symbol? x)
              (list? x))
    (fail-expression-check
     "Must be either a symbol or a list." (list x)))

  (define type
    (labelinglogic:expression:type x))

  (define args
    (labelinglogic:expression:args x))

  (cond
   ((equal? type 'constant) 'ok)
   ((equal? 'or type) 'ok) ;; any arity is ok.
   ((equal? '= type)
    (unless (list-length= 1 args)
      (fail-expression-check
       (stringf
        "Expression of type ~s must have exactly 1 argument."
        (~a '=))
       (list x))))

   ((equal? 'r7rs type)
    (unless (list-length= 1 args)
      (fail-expression-check
       (stringf
        "Expression of type ~s must have exactly 1 argument."
        (~a 'r7rs))
       (list x))))

   (else
    (fail-expression-check
     "Expression type unrecognized."
     (list x)))))
