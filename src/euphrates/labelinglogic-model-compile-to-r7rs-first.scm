;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:compile-to-r7rs/first model)
  (define input-name 'x)
  (define cond-stack (stack-make))
  (define inlined-model (labelinglogic:model:inline-all model))

  (define (compile-expression expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (cond
     ((equal? type 'constant)
      (let ()
        (define arg (car args))
        `(equal? ,input-name ,arg)))

     ((equal? type 'r7rs)
      (let ()
        (define arg (car args))
        `(,arg ,input-name)))

     ((member type (list 'or 'and 'not)) ;; TODO: investigate if appending #f/#t at the end gains speed.
      (let ()
        (define recursed (map compile-expression args))
        `(,type ,@recursed)))

     ((equal? type 'tuple) ;; TODO: support this
      (raisu* :from "labelinglogic:model:compile-to-r7rs/first"
              :type 'xor-not-supported
              :message (stringf "Expression type ~s not supported here" (~a type))
              :args (list type expr)))

     ((equal? type 'xor)
      (raisu* :from "labelinglogic:model:compile-to-r7rs/first"
              :type 'xor-not-supported
              :message (stringf "Expression type ~s not supported here" (~a type))
              :args (list type expr)))

     (else
      (raisu* :from "labelinglogic:model:compile-to-r7rs/first"
              :type 'unknown-expr-type
              :message (stringf "Expression type ~s not recognized" (~a type))
              :args (list type expr)))))

  (define bindings
    (labelinglogic:model:bindings
     inlined-model))

  (define (constant-binding? binding)
    (define name (labelinglogic:binding:name binding))
    (define expr (labelinglogic:binding:expr binding))
    (define type (labelinglogic:expression:type expr))
    (equal? type 'constant))

  (define sorted-bindings
    (append
     (filter constant-binding? bindings)
     (filter (negate constant-binding?) bindings)))

  (define _loop
    (for-each
     (lambda (binding)
       (define name (labelinglogic:binding:name binding))
       (define expr (labelinglogic:binding:expr binding))
       (define predicate (compile-expression expr))
       (define qname (list 'quote name))
       (stack-push! cond-stack (list predicate qname)))

     sorted-bindings))

  (define cases (reverse (stack->list cond-stack)))

  `(lambda (,input-name)
     (cond ,@cases (else #f))))
