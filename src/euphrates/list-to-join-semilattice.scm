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
    (map make-olnode lst))

  (define graph
    (make-olgraph initial-nodes))

  (define all-nodes initial-nodes)
  (define current-layer initial-nodes)

  (define (find-existing-node needle-value)
    (list-find-first
     (lambda (other)
       (equality-tester
        needle-value
        (olnode:value other)))
     #f all-nodes))

  (define (prepend-node! parent child)
    (define (equal-to-child? other)
      (equal? (olnode:id child)
              (olnode:id other)))

    (unless (equal-to-child? parent)
      (unless (list-or-map
               equal-to-child?
               (olnode:children parent))
        (olnode:prepend-child! parent child))))

  (define (make-new-node! value)
    (define new (make-olnode value))
    (set! current-layer (cons new current-layer))
    (set! all-nodes (cons new all-nodes))
    new)

  (define (make-join-node! value)
    (define existing (find-existing-node value))
    (or existing (make-new-node! value)))

  (define (add-join-point! node-x node-y value)
    (define to-add (make-join-node! value))
    (prepend-node! node-x to-add)
    (prepend-node! node-y to-add)
    (values))

  (define (join! node-x node-y)
    (define join-result
      (call-with-values
          (lambda _
            (join-function
             (olnode:value node-x)
             (olnode:value node-y)))
        list))

    (unless (null? join-result)
      (unless (null? (cdr join-result))
        (raisu* :from "list->join-semilattice"
                :type 'bad-number-of-values
                :message (stringf "Expected either 0 or 1 value, got ~s." (length join-result))
                :args (list join-result node-x node-y)))

      (add-join-point! node-x node-y (car join-result))))

  (let loop ()
    (define copy current-layer)
    (set! current-layer '())

    (unless (null? copy)
      (cartesian-each
       (lambda (x y)

         (when (and
                (equal? (olnode:value x)
                        '(1 2))
                ;; (equal? (olnode:value y)
                ;;         '(7 1))
                )
           (debug "YES!"))

         (unless (equal? (olnode:id x) (olnode:id y))
           (join! x y)))
       all-nodes
       all-nodes)

      (loop)))

  graph)
