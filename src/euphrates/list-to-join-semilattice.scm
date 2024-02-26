;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (list->join-semilattice equality-tester join-function lst)
  ;;
  ;; The `list->join-semilattice` function generates a join semilattice graph
  ;; from a given list. A semilattice is a partially ordered set with a
  ;; function operation - known as the join - which finds the smallest common
  ;; successor for any pair of elements. This function is useful in
  ;; understanding the properties and relationships between elements of a list.
  ;;
  ;; Parameters:
  ;;
  ;; - `equality-tester`: This is a function that checks the equality between
  ;;                      two elements. The nature of the `equality-tester`
  ;;                      function will depend on the specific elements within
  ;;                      your list. For instance, if your list is composed of
  ;;                      integers, your `equality-tester` could be
  ;;                      a simple `equal?` function.
  ;;
  ;; - `join-function`: This is a function that produces either a common
  ;;                    successor of two list elements (also known as a join
  ;;                    point in the context of semilattices), or returns `void`
  ;;                    (the type of `(values)` expression) if there's no join
  ;;                    point. For example, if you're working with a list of
  ;;                    integers, you might use the `greatest-common-divisor`
  ;;                    function as your `join-function`.
  ;;
  ;; - `lst`: This is the list of elements you want to transform. The type of
  ;;          list elements can be flexible, with the condition that the
  ;;          `equality-tester` and `join-function` can handle such type.
  ;;          For example, this could be a list of integers `(1 2 3 4 5)`.
  ;;
  ;; The result of `list->join-semilattice` is an `olgraph`,
  ;; where each node represents a node in the graph and its direct
  ;; successors. A sublist starts with a node's value and following
  ;; elements are its direct successors. Note that if a successor appears
  ;; in multiple sublist, it means it is a common successor of different nodes.
  ;;
  ;; Example:
  ;;
  ;; (list->join-semilattice
  ;;   equal? greatest-common-divisor
  ;;   '(1 2 3 4 5))
  ;;
  ;; |> olgraph->adjlist
  ;;
  ;; produces the list `((1) (2 1) (3 1) (4 2) (5 1))`
  ;;
  ;; In this case, for instance, elements `2` and `3`
  ;; have the common successor `1`, and `4` is succeeded by `2`.
  ;; Note that `1` is not succeded by itself, even thought GCD(1, 1) = 1,
  ;; because loops are prohibited in the resulting graph
  ;; (such graphs are not lattices).
  ;;
  ;; Corner Cases:
  ;;
  ;; - If `lst` is an empty list, the function will return an empty graph.
  ;;
  ;; - If `lst` contains elements that cannot be processed by `equality-tester`
  ;;   or `join-function`, an error will be raised.
  ;;
  ;; - If `join-function` returns multiple join points for
  ;;   the same pair of nodes, an error will be triggered.
  ;;
  ;; Performance Considerations:
  ;;
  ;; - This function can be computationally intensive for large lists due to
  ;;   the potential for pairwise comparisons, so consider this when dealing
  ;;   with larger datasets.
  ;;

  (define initial-nodes
    (map make-olnode lst))

  (define graph
    (make-olgraph initial-nodes))

  (define all-nodes initial-nodes)
  (define top-layer initial-nodes)

  (define (find-existing-node needle-value)
    (list-find-first
     (lambda (other)
       (equality-tester
        needle-value
        (olnode:value other)))
     #f all-nodes))

  (define (prepend-node! parent child)
    (define (equal-to-child? other)
      (olnode-eq? child other))

    (unless (equal-to-child? parent)
      (unless (list-or-map
               equal-to-child?
               (olnode:children parent))
        (olnode:prepend-child! parent child))))

  (define (make-new-node! value)
    (define new (make-olnode value))
    (set! top-layer (cons new top-layer))
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
    (define copy top-layer)
    (set! top-layer '())
    (unless (null? copy)
      (cartesian-each
       (lambda (x y)
         (unless (olnode-eq? x y)
           (join! x y)))

       copy copy)

      (loop)))

  (olgraph-remove-transitive-edges graph))
