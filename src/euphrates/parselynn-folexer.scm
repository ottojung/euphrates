;;;; Copyright (C) 2023, 2024  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (make-parselynn:folexer tokens-alist)

  (define singletons-tokens-alist/stack
    (stack-make))

  (define chars-of-strings-map
    (make-hashmap))

  (define long-strings-alist/stack
    (stack-make))

  (define _64132
    (for-each
     (lambda (p)
       (define-pair (name value) p)
       (cond
        ((and (string? value)
              (= 1 (string-length value)))

         (stack-push!
          singletons-tokens-alist/stack
          (cons name (string-ref value 0))))

        ((and (string? value)
              (= 0 (string-length value)))

         (stack-push!
          singletons-tokens-alist/stack
          (cons name labelinglogic:expression:bottom)))

        ((and (string? value)
              (not (= 1 (string-length value))))

         (stack-push!
          singletons-tokens-alist/stack
          (cons name
                (labelinglogic:expression:make
                 'tuple
                 (map
                  (lambda (c)
                    (labelinglogic:expression:make
                     '= (list c)))
                  (string->list value))))))

        (else
         (stack-push!
          singletons-tokens-alist/stack
          (cons name value)))))

     tokens-alist))

  (define long-strings-alist
    (reverse
     (stack->list
      long-strings-alist/stack)))

  (define singletons-tokens-alist
    (reverse
     (stack->list
      singletons-tokens-alist/stack)))

  (define (parse-token-pair p)
    (define-pair (name value) p)

    (define expr
      (let loop ((value value))

        (cond
         ((char? value)
          (list '= value))

         ((equal? 'class (car value))
          (cadr value))

         ((equal? '= (car value))
          value)

         ((equal? 'tuple (car value))
          value)

         ((labelinglogic:expression:bottom? value)
          value)

         (else
          (raisu* :from "parselynn:folexer"
                  :type 'bad-token-type
                  :message (stringf "Unknown element of ~s in folexer lexer" (~a (quote singletons-tokens-alist)))
                  :args (list value))))))

    (labelinglogic:binding:make
     name expr))

  (define bindings
    (map parse-token-pair singletons-tokens-alist))

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

  (define (dereference-while-variable expr)
    (let loop ((expr expr))
      (define type (labelinglogic:expression:type expr))
      (if (equal? type 'variable)
          (let ()
            (define target (labelinglogic:model:assoc expr opt-model))
            (define target-type (labelinglogic:expression:type target))
            (if (equal? target-type 'variable)
                (loop target)
                expr))
          expr)))

  (define _123554
    (for-each
     (lambda (p)
       (define-pair (string-name chars-names) p)
       (define dereferenced-names (map dereference-while-variable chars-names))
       (define rule (cons string-name (list dereferenced-names)))
       (stack-push! additional-grammar-rules/stack rule))
     long-strings-alist))

  (define _2341723
    (for-each
     (lambda (binding)
       (define class (labelinglogic:binding:name binding))
       (define expr (labelinglogic:binding:expr binding))
       (define type (labelinglogic:expression:type expr))
       (define args (labelinglogic:expression:args expr))
       (define token-value (assoc-or class singletons-tokens-alist #f))

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
         (unless (hashmap-has? chars-of-strings-map class)
           (let ()
             (define rule (list class (list expr)))
             (stack-push! additional-grammar-rules/stack rule))))

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
