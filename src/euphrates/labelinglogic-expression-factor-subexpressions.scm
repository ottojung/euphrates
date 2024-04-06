;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:expression:factor-subexpressions predicate expr)
  (define bindings (stack-make))
  (define orig-expr expr)

  (define type (labelinglogic:expression:type expr))
  (define args (labelinglogic:expression:args expr))
  (define new-args
    (map
     (lambda (expr)
       (labelinglogic:expression:map-subexpressions
        (lambda (expr)
          (cond
           ((predicate expr)
            (let ()
              (define name (make-unique-identifier))
              (define binding (labelinglogic:binding:make name expr))
              (stack-push! bindings binding)
              name))
           (else expr)))
        expr))
     args))

  (define new-expr
    (if (stack-empty? bindings)
        orig-expr
        (labelinglogic:expression:make type new-args)))

  (values new-expr (reverse (stack->list bindings))))
