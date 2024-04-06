;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:deduplicate-subexpressions model)
  (define H (make-hashmap))

  (define _766414
    (labelinglogic:model:foreach-expression
     (lambda (class predicate)
       (lambda (expr)
         (define type (labelinglogic:expression:type expr))
         (hashmap-set! H class class)
         (unless (hashmap-has? H predicate)
           (hashmap-set! H predicate class))))

     model))

  (define S (make-multiset))

  (define _172371
    (labelinglogic:model:foreach-subexpressions
     (lambda (class predicate)
       (lambda (expr) (multiset-add! expr)))
     model))

  (define _127371273
    (multiset-foreach/key-value
     (lambda (key value)
       (when (< 1 value)
         (unless (hashmap-has? H key)
           (hashmap-set!
            H key
            (make-unique-identifier)))))))

  (define new-bindings-stack
    (stack-make))

  ;; (define replaced-model
  ;;   (labelinglogic:model:map-subexpressions
  ;;    (lambda (class predicate)
  ;;      (if (equal? class (hashmap-ref H predicate #f))
  ;;          identity
  ;;          (lambda (expr)
  ;;            (hashmap-ref
  ;;             H expr
  ;;             (let ()
  ;;               (define name
  ;;                 (make-unique-identifier))
  ;;               (define binding
  ;;                 (labelinglogic:binding:make name expr))

  ;;               (stack-push! new-bindings-stack binding)
  ;;               (hashmap-set! H expr name)
  ;;               name)))

  0)


