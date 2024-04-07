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

  (define renamed-model
    (labelinglogic:model:alpha-rename
     taken-token-names-set
     opt-model))

  (define additional-grammar-rules/stack
    (stack-make))

  (define lexer-model/stack
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
         (stack-push! lexer-model/stack binding))
        ((member type (list 'or 'constant))
         'do-them-later-when-the-lexer-model-is-available)
        (else
         (raisu 'unexpected-expr-type type args binding))))

     (labelinglogic:model:bindings
      renamed-model)))

  (define lexer-model
    (stack->list lexer-model/stack))

  (define _6478237
    (for-each
     (lambda (binding)
       (define class (labelinglogic:binding:name binding))
       (define expr (labelinglogic:binding:expr binding))
       (define type (labelinglogic:expression:type expr))
       (define args (labelinglogic:expression:args expr))
       (define token-value (assoc-or class tokens-alist #f))

       (cond
        ((equal? type 'constant)
         (let ()
           (define rule (cons class (list expr)))
           (stack-push! additional-grammar-rules/stack rule)))

        ((equal? type 'or)
         (cond
          ((string? token-value)
           (let ()
             (define letters (string->list token-value))
             (define tokens (map (lambda (c) (labelinglogic:model:evaluate/first lexer-model c)) letters))
             (define rule (cons class (list tokens)))
             (stack-push! additional-grammar-rules/stack rule)))

          (else
           (let ()
             (define rule (cons class (map list args)))
             (stack-push! additional-grammar-rules/stack rule)))))))

     (labelinglogic:model:bindings
      renamed-model)))

  (define additional-grammar-rules
    (stack->list additional-grammar-rules/stack))

  (make-parselynn/singlechar-struct
   additional-grammar-rules
   lexer-model))
