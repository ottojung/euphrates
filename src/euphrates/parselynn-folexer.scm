;;;; Copyright (C) 2023, 2024  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (make-parselynn:folexer tokens-alist)

  (define bindings
    (map
     (lambda (p)
       (define-pair (name value) p)
       (parselynn:folexer:expression:check value)
       (labelinglogic:binding:make
        name (parselynn:folexer:expression->labelinglogic:expression value)))
     tokens-alist))

  (define full-model
    (labelinglogic:model:append
     parselynn-folexer-model
     bindings))

  (define _61237
    (labelinglogic:model:check full-model))

  (define exported-names/set
    (list->hashset
     (map labelinglogic:binding:name bindings)))

  (define opt-model
    (labelinglogic:model:to-minimal-dnf/assuming-nointersect
     exported-names/set full-model))

  (define additional-grammar-rules/stack
    (stack-make))

  (define base-model/stack
    (stack-make))

  (define _2341723
    (for-each
     (lambda (binding)
       (define class (labelinglogic:binding:name binding))
       (define expr (labelinglogic:binding:expr binding))
       (define type (labelinglogic:expression:type expr))
       (define args (labelinglogic:expression:args expr))

       (cond
        ((member type (list '= 'r7rs 'and))
         (stack-push! base-model/stack binding))

        ((member type (list 'or))
         (let ()
           (define rule
             (if (null? args)
                 (list class (list))
                 (cons class (map list args))))
           (stack-push! additional-grammar-rules/stack rule)))

        ((member type (list 'tuple))
         (let ()
           (define rule (list class args))
           (stack-push! additional-grammar-rules/stack rule)))

        ((member type (list 'variable))
         (let ()
           (define rule (list class (list expr)))
           (stack-push! additional-grammar-rules/stack rule)))

        (else
         (raisu 'unexpected-expr-type type args binding))))

     (labelinglogic:model:bindings
      opt-model)))

  (define base-model
    (reverse
     (stack->list
      base-model/stack)))

  (define additional-grammar-rules
    (reverse
     (stack->list
      additional-grammar-rules/stack)))

  (define renamed-base-model
    (labelinglogic:model:alpha-rename base-model))

  (define renamed-grammar-rules
    (unique-identifier->symbol/recursive
     additional-grammar-rules))

  (make-parselynn:folexer-struct
   renamed-grammar-rules
   renamed-base-model))
