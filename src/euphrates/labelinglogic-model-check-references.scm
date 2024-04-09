;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:check-references external-names/set model)
  (define (fail-ref-check show args)
    (raisu* :from "labelinglogic:model:check-references"
            :type 'model-type-error
            :message (stringf "Type error in ~s: ~a." (quote model) show)
            :args args))

  (define names
    (labelinglogic:model:names model))

  (define bindings
    (labelinglogic:model:bindings model))

  (define duplicates
    (list-get-duplicates
     (filter
      (negate unique-identifier?)
      names)))

  (define _831623
    (unless (null? duplicates)
      (fail-ref-check
       "names must not repeat"
       (list duplicates))))

  (define names/set
    (list->hashset names))

  (define redefined
    (hashset-intersection names/set external-names/set))

  (unless (hashset-null? redefined)
    (fail-ref-check
     "redefinition is not allowed"
     (list (hashset->list redefined))))

  (for-each
   (lambda (binding)
     (define name (labelinglogic:binding:name binding))
     (define expr (labelinglogic:binding:expr binding))
     (define variables (labelinglogic:expression:variables expr))

     (define undefined-variables
       (filter (negate
                (lambda (x)
                  (or (hashset-has? external-names/set x)
                      (hashset-has? names/set x))))
               variables))

     (unless (null? undefined-variables)
       (fail-ref-check
        "binding references undefined class"
        (list name undefined-variables)))

     )

   bindings)

  (define (check-recursion binding)
    (define stack (list))
    (define class (labelinglogic:binding:name binding))
    (define predicate (labelinglogic:binding:expr binding))

    (let loop ((class class)
               (predicate predicate)
               (stack stack))

      (define new-stack (cons class stack))

      (when (member class stack)
        (let ()
          (define cycle (reverse new-stack))

          (fail-ref-check
           (stringf "class references itself through the following cycle: ~s, this is not allowed" cycle)
           (list class cycle))))

      (define variables (labelinglogic:expression:variables predicate))
      (define referenced
        (filter
         identity
         (map (lambda (c)
                (and (hashset-has? names/set c)
                     (cons c (labelinglogic:model:assoc c model))))
              variables)))

      (for-each
       (lambda (p)
         (define-pair (c e) p)
         (loop c e new-stack))
       referenced)))

  (for-each check-recursion bindings)

  (when #f #t))
