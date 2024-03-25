;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:check/nothrow x)
  (define (fail-expression-check show args)
    (vector "labelinglogic:expression:check"
            'expression-type-error
            (stringf "Type error: ~a." show)
            args))

  (and

   (or (symbol? x)
       (unique-identifier? x)
       (number? x)
       (list? x)

       (fail-expression-check
        "Must be either a symbol or a list." (list x)))

   (let ()
     (define type
       (labelinglogic:expression:type x))

     (define args
       (labelinglogic:expression:args x))

     (define (recurse args)
       (list-map-first labelinglogic:expression:check/nothrow #f args))

     (cond
      ((equal? type 'constant) #f)
      ((equal? 'or type) (recurse args)) ;; any arity is ok.
      ((equal? 'and type) (recurse args)) ;; any arity is ok.
      ((equal? 'xor type) (recurse args)) ;; any arity is ok.

      ((equal? 'tuple type)
       (and

        (or (list-length=<? 1 args)
            (fail-expression-check
             (stringf
              "Expression of type ~s must have at least 1 argument."
              (~a type))
             (list x)))

        (recurse args)))

      ((equal? 'not type)
       (and

        (or (list-length= 1 args)
            (fail-expression-check
             (stringf
              "Expression of type ~s must have exactly 1 argument."
              (~a type))
             (list x)))
        (recurse args)))

      ((equal? '= type)
       (or (list-length= 1 args)
           (fail-expression-check
            (stringf
             "Expression of type ~s must have exactly 1 argument."
             (~a type))
            (list x))))

      ((equal? 'r7rs type)
       (and

        (or (list-length= 1 args)
            (fail-expression-check
             (stringf
              "Expression of type ~s must have exactly 1 argument."
              (~a type))
             (list x)))

        (or (procedure?
             (labelinglogic:expression:compile/r7rs x))
            (fail-expression-check
             (stringf
              "Expression of type ~s must compile to a R7RS scheme procedure."
              (~a type))
             (list x)))))

      (else
       (fail-expression-check
        "Expression type unrecognized."
        (list x)))))))
