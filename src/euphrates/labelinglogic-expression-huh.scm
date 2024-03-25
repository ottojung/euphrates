;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression? x)
  (and (or (symbol? x)
           (unique-identifier? x)
           (number? x)
           (list? x))
       (let ()
         (define type
           (labelinglogic:expression:type x))

         (define args
           (labelinglogic:expression:args x))

         (define (recurse args)
           (list-and-map labelinglogic:expression? args))

         (cond
          ((equal? type 'constant) #t)
          ((equal? 'or type) (recurse args)) ;; any arity is ok.
          ((equal? 'and type) (recurse args)) ;; any arity is ok.
          ((equal? 'xor type) (recurse args)) ;; any arity is ok.

          ((equal? 'tuple type)
           (and (list-length=<? 1 args)
                (recurse args)))

          ((equal? 'not type)
           (and (list-length= 1 args)
                (recurse args)))

          ((equal? '= type)
           (list-length= 1 args))

          ((equal? 'r7rs type)
           (unless (list-length= 1 args)
             (fail-expression-check
              (stringf
               "Expression of type ~s must have exactly 1 argument."
               (~a type))
              (list x)))

           (unless (procedure?
                    (labelinglogic:expression:compile/r7rs x))
             (fail-expression-check
              (stringf
               "Expression of type ~s must compile to a R7RS scheme procedure."
               (~a type))
              (list x))))

          (else
           (fail-expression-check
            "Expression type unrecognized."
            (list x)))))

