;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (list->join-semilattice
         equality-tester
         join-function
         lst)

  ;;
  ;; Let U : Type
  ;; Then
  ;; lst: List[U]
  ;; equality-tester: U, U -> boolean
  ;; join-function: \forall x,y,z \in U . x, y -> Union[z, void]
  ;; list->join-semilattice: ... -> olgraph[z]
  ;;
  ;; Where `void` is the type of `(values)` expression.
  ;;
  ;; Join returns either the join point of the two nodes,
  ;; or void in case there is no join between them.
  ;;

  (define initial-nodes
    (map
     (lambda (value)
       (define children '())
       (define meta #f)
       (make-olnode value children meta))
     lst))

  (define graph
    (make-olgraph initial-nodes))

  (define all-nodes initial-nodes)

  (define (find-existing-node needle-value)
    (list-find-first
     (lambda (other)
       (equality-tester
        needle-value
        (olnode:value other)))
     #f all-nodes))

  (let loop ((current-layer initial-nodes))
    (cartesian-each
     (lambda (x y)
       (unless (equal? (olnode:id x) (olnode:id y))
         
       0)
     current-layer
     current-layer))

  graph)
