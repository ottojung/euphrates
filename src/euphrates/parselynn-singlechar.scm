;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (make-parselynn/singlechar
         taken-token-names-set tokens-alist)

  (define (parse-token-pair p)
    (define-pair (name value) p)

    (define expr
      (let loop ((value value))

        (cond
         ((char? value)
          (list '= value))

         ((string? value)
          (cons 'tuple (map loop (string->list value))))

         ((equal? 'class (car value))
          (cadr value))

         ((equal? '= (car value))
          value)

         (else
          (raisu* :from "parselynn/singlechar"
                  :type 'bad-token-type
                  :message (stringf "Unknown element of ~s in singlechar lexer" (~a (quote tokens-alist)))
                  :args (list value))))))

    (labelinglogic:binding:make
     name expr))

  (define bindings
    (map parse-token-pair tokens-alist))

  (define full-model
    (labelinglogic:model:append
     parselynn-singlechar-model
     bindings))

  (define _61237
    (labelinglogic:model:check full-model))

  (define exported-names/set
    (list->hashset
     (map labelinglogic:binding:name bindings)))

  (define opt-model
    (labelinglogic:model:minimize/assuming-nointersect
     exported-names/set full-model))

  (define factored-model
    (labelinglogic:model:factor-dnf-clauses
     opt-model))

  (debugs factored-model)

  (define renamed-model
    (labelinglogic:model:alpha-rename
     taken-token-names-set
     factored-model))

  (debugs renamed-model)

  (define singleton-map
    (make-hashmap))

  (define additional-grammar-rules/singletons/stack
    (stack-make))

  (define categories/stack
    (stack-make))

  (for-each
   (lambda (binding)
     (define class
       (labelinglogic:binding:name binding))
     (define predicate
       (labelinglogic:binding:expr binding))
     (define type
       (labelinglogic:expression:type predicate))
     (define args
       (labelinglogic:expression:args predicate))

     (cond
      ((equal? type '=)
       (hashmap-set! singleton-map (car args) class))
      ((equal? type 'r7rs)
       (stack-push! categories/stack binding))
      ((equal? type 'or)
       (stack-push! additional-grammar-rules/singletons/stack
                    (cons class (map list args))))
      ((equal? type 'tuple)
       (stack-push! additional-grammar-rules/singletons/stack
                    (cons class (list args))))
      (else
       (raisu 'uknown-expr-type type args))))

   (labelinglogic:model:bindings
    renamed-model))

  (define categories
    (stack->list categories/stack))

  (define additional-grammar-rules
    (stack->list additional-grammar-rules/singletons/stack))

  (make-parselynn/singlechar-struct
   additional-grammar-rules
   categories singleton-map))
