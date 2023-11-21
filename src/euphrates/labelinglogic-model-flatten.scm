;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:flatten model)
  (define H (make-hashmap))
  (define stack (stack-make))

  (define (loop-expr expr)
    (debugs expr)

    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (debugs type)

    (cond
     ((equal? 'constant type) expr)
     (else
      (let ()
        (define existing
          (hashmap-ref H expr #f))

        (debugs existing)

        (define alias
          (or existing (make-unique-identifier)))

        (debugs alias)

        (unless existing
          (hashmap-set! H expr alias)
          (stack-push!
           stack
           (labelinglogic:binding:make alias expr)))

        (debug "DONE")

        alias))))

  (define (factor-out-expr expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (cond
     ((member type (list 'or 'and 'tuple 'not 'xor))
      (labelinglogic:expression:make
       type (map loop-expr args)))

     ((member type (list '= 'constant 'r7rs))
      (loop-expr expr))

     (else
      (raisu* :from "labelinglogic:model:flatten"
              :type 'unknown-expr-type
              :message (stringf "Expression type ~s not recognized"
                                (~a type))
              :args (list type expr)))))

  ;; Just to remember the current aliases.
  (labelinglogic:model:map-expressions
   (lambda (class predicate)
     (lambda (expr)
       (hashmap-set! H predicate class)))
   model)

  (debugs H)

  (define maped-model
    (labelinglogic:model:map-subexpressions
     (const factor-out-expr)
     model))

  (define complete-model
    (append
     maped-model
     (reverse
      (stack->list stack))))

  complete-model)
