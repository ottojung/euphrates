;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:latticize-ands-assuming-nointersect-dnf model)

  (define (nicolaus? x)
    (and (labelinglogic:expression? x)
         (let loop ((expr x))
           (define type (labelinglogic:expression:type expr))
           (define args (labelinglogic:expression:args expr))

           (or (equal? 'r7rs type)
               (and (equal? 'and type)
                    (list-or-map loop args))))))

  (define nicolaus-stack (stack-make))

  (define _1237123
    (labelinglogic:model:foreach-expression
     (lambda _
       (lambda (expr)
         (define type (labelinglogic:expression:type expr))
         (define args (labelinglogic:expression:args expr))

         (define terms
           (if (equal? 'or type) args (list expr)))

         (define nicolauses
           (filter nicolaus? terms))

         (for-each
          (lambda (nic) (stack-push! nicolaus-stack nic))
          nicolauses)))

     model))

  (define equalp
    labelinglogic:expression:equal?/syntactic/order-independent)

  (define nicolauses/dup
    (stack->list nicolaus-stack))

  (define nicolauses
    (list-idempotent/left equalp nicolauses/dup))

  (define (get-ands expr)
    (define type (labelinglogic:expression:type expr))
    (define args (labelinglogic:expression:args expr))

    (if (equal? 'and type) args (list expr)))

  (define (join expr-1 expr-2)
    (define ands-1 (get-ands expr-1))
    (define ands-2 (get-ands expr-2))
    (define new-ands (list-union ands-1 ands-2))
    (define new (labelinglogic:expression:make 'and new-ands))
    (define new-opt
      (labelinglogic:expression:optimize/assuming-nointersect
       new))

    (if (labelinglogic:expression:bottom? new-opt)
        (values)
        new-opt))

  (define lattice
    (list->join-semilattice
     equalp join nicolauses))

  (define lattice-list
    (olgraph->adjlist lattice))

  (debugs lattice-list)

  model)
