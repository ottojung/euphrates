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
          (cons 'or (map loop (string->list value))))

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
    (labelinglogic:model:to-minimal-dnf/assuming-nointersect
     exported-names/set full-model))

  (debugs opt-model)

  (define renamed-model
    (labelinglogic:model:alpha-rename
     taken-token-names-set
     opt-model))

  (debugs renamed-model)

  (define singleton-map
    (make-hashmap))

  (define additional-grammar-rules/stack
    (stack-make))

  (define todo-strings/stack
    (stack-make))

  (define categories/stack
    (stack-make))

  (define (add-grammar-rule! class expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))
    (define token-value
      (assoc-or class tokens-alist
                (raisu 'impossible-172371273 class tokens-alist)))

    (cond
     ((string? token-value)
      (stack-push! todo-strings/stack (list class expr token-value)))
     (else
      (let ()
        (define rule
          (cons class (map list args)))
        (stack-push! additional-grammar-rules/stack rule)))))


  (labelinglogic:model:foreach-expression
   (lambda (class predicate)
     (lambda (expr)
       (define type (labelinglogic:expression:type expr))
       (define args (labelinglogic:expression:args expr))

       (cond
        ((equal? type '=)
         (hashmap-set! singleton-map (car args) class))
        ((equal? type 'or)
         (add-grammar-rule! class expr))
        ((member type (list 'and 'r7rs))
         (stack-push! categories/stack (list class expr)))
        (else
         (raisu 'uknown-expr-type type args)))))

    renamed-model)

  (define categories
    (stack->list categories/stack))

  (define additional-grammar-rules
    (stack->list additional-grammar-rules/stack))

  (make-parselynn/singlechar-struct
   additional-grammar-rules
   categories singleton-map))
