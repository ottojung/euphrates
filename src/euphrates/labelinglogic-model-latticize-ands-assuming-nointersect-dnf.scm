;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (labelinglogic:model:latticize-ands-assuming-nointersect-dnf model)
  (define equalp
    labelinglogic:expression:equal?/syntactic/order-independent)

  (define nicolauses/dup
    (labelinglogic:model:collect-dnf-r7rs-clauses model))

  (define nicolauses
    (apply-until-fixpoint
     (lambda (lst)
       (list-idempotent equalp lst))
     nicolauses/dup))

  (debugs nicolauses)

  (define (join expr-1 expr-2)
    (define new
      (labelinglogic:expression:make
       'and (list expr-1 expr-2)))

    (define new-opt
      (labelinglogic:expression:optimize/assuming-nointersect-dnf
       new))

    (if (labelinglogic:expression:bottom? new-opt)
        (values)
        new-opt))

  (define lattice
    (list->join-semilattice
     equalp join nicolauses))

  (define lattice-adjlist
    (olgraph->adjlist lattice))

  (debugs lattice-adjlist)

  (define lattice-renames-stack
    (stack-make))

  (define lattice-bodies-map
    (make-hashmap))

  (define lattice-reverse-renames-map
    (make-hashmap))

  (define lattice-completed-bodies-map
    (make-hashmap))

  (define (complete-bodies parent children)
    (define children-or
      (labelinglogic:expression:make 'or children))

    (labelinglogic:expression:to-dnf
     (labelinglogic:expression:make
      'or (list
           children-or
           (labelinglogic:expression:optimize/assuming-nointersect
            (labelinglogic:expression:make
             'and (list parent
                        (labelinglogic:expression:make
                         'not (list children-or)))))))))

  (define _318237
    (for-each
     (lambda (adj)
       (define-pair (parent children) adj)
       (define name (make-unique-identifier))

       (stack-push!
        lattice-renames-stack
        (cons parent name))

       (hashmap-set!
        lattice-reverse-renames-map
        name parent)

       (hashmap-set!
        lattice-bodies-map
        name children)

       (hashmap-set!
        lattice-completed-bodies-map
        name (complete-bodies parent children))

       )

     lattice-adjlist))

  (define lattice-renames-alist
    (stack->list lattice-renames-stack))

  (define model-with-added-nicolauses
    (labelinglogic:model:append
     (hashmap->alist
      lattice-completed-bodies-map)))

  (debugs model-with-added-nicolauses)

  model)
