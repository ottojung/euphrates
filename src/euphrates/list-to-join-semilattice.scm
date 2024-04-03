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
  ;;                      In fact, `equality-tester` must be a restriction of
  ;;                      the function `equal?`.
  ;;
  ;; - `join-function`: This is a function that produces either a common
  ;;                    successor of two list elements (also known as a join
  ;;                    point in the context of semilattices), or returns `void`
  ;;                    (the type of `(values)` expression) if there's no join
  ;;                    point. For example, if you're working with a list of
  ;;                    integers, you might use the `greatest-common-divisor`
  ;;                    function as your `join-function`.
  ;;                    The join function must return the same value for any two
  ;;                    equal inputs, as determined by `equality-tester`.
  ;;                    This function should be commutative and associative, i.e.:
  ;;                       let f = join-function, then:
  ;;                       (join-function x y) == (join-function y x)  \forall x, y
  ;;                       (f x (f y z)) == (f (f x y) z)              \forall x, y, z.
  ;;                    Idempotency may be skipped, see what happens and if you are okay with it.
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
  ;;   |> olgraph->adjlist
  ;;
  ;; produces the list `((1) (2 1) (3 1) (4 2) (5 1))`.
  ;;
  ;; In this case, for instance, elements `2`, `3` and `5`,
  ;; have the common successor `1`, and `4` is succeeded by `2`.
  ;; Note that `1` is not succeded by itself, even thought GCD(1, 1) = 1,
  ;; because loops are prohibited in the resulting graph
  ;; (such graphs are not lattices).
  ;;
  ;; Corner Cases:
  ;;
  ;; - If `lst` is an empty list, the function will return an empty graph.
  ;;
  ;; - Disjoint subgraphs can be produced if `join-function` so desires,
  ;;   even though they are not formally lattices.
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
  (define top-layer-indexes (make-hashset))

  (define (find-existing-node needle-value)
    (let loop ((rest all-nodes))
      (if (null? rest) #f
          (let ()
            (define other (car rest))
            (if (equality-tester
                 needle-value
                 (olnode:value other))
                other
                (loop (cdr rest)))))))

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
    (set! all-nodes (cons new all-nodes))
    new)

  (define (make-join-node! value)
    (define existing (find-existing-node value))
    (or existing (make-new-node! value)))

  (define (add-join-point! current-level node-x node-y value)
    (define to-add (make-join-node! value))
    (define existing-level (olnode:meta to-add))

    (unless (and (number? existing-level)
                 (= existing-level current-level))
      (set! top-layer (cons to-add top-layer))
      (olnode:meta:set! to-add current-level))

    (prepend-node! node-x to-add)
    (prepend-node! node-y to-add)
    (values))

  (define (join! level node-x node-y)
    (define join-result
      (call-with-values
          (lambda _
            (define left (olnode:value node-x))
            (define right (olnode:value node-y))
            (join-function left right))
        list))

    (unless (null? join-result)
      (if (null? (cdr join-result))
          (add-join-point! level node-x node-y (car join-result))
          (raisu* :from "list->join-semilattice"
                  :type 'bad-number-of-values
                  :message (stringf "Expected either 0 or 1 value, got ~s." (length join-result))
                  :args (list join-result node-x node-y)))))

  (let loop ((level 0))
    (define copy top-layer)

    (debug "=================")
    (debugs (map olnode:value top-layer))
    (debug "-----------------")

    (set! top-layer '())
    (hashset-clear! top-layer-indexes)

    (unless (null? copy)
      (let xloop ((xlist copy))
        (unless (null? xlist)
          (let ()
            (define left (car xlist))
            (let yloop ((ylist (cdr xlist)))
              (unless (null? ylist)
                (let ()
                  (define right (car ylist))
                  (join! level left right)
                  (yloop (cdr ylist))))))
          (xloop (cdr xlist))))

      (loop (+ 1 level))))

  (olgraph-reverse-children-inplace! graph)
  (olgraph-remove-transitive-edges graph))
