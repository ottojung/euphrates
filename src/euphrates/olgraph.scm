;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; Ordered List Graph Data Structure

;; An OLgraph (Ordered List Graph) is a representation
;; of a directed graph using ordered edge lists. The graph is made up of "initial" nodes
;; (olgraph) which may have any number of "children" nodes (olnodes).

;; This is a powerful structure that allows for complex looped and branching relationships
;; between nodes, provided they are directed and ordered. There is even the possibility
;; for repeating edges.


;; OLGRAPH

;; OLgraph is a list of initial OLNodes, which serves as the 'root' or starting point
;; of graph exploration.
;;
;; This structure is completely optional,
;; and all graph operations should be based on the OLNode.
;;

(define-type9 olgraph
  (make-olgraph initial) olgraph?
  (initial olgraph:initial olgraph:initial:set!)
  )


(define (olgraph:prepend-initial! graph node)
  (olgraph:initial:set! graph (cons node (olgraph:initial graph))))


;; OLNODE

;; Each OLNode represents a node in the graph, and includes several properties:
;; * ID: A unique identifier for the node. This is used for efficient strong equality (think eq? and hash-eq).
;; * Value: This represents the value or data held in the node.
;; * Children: List of OLNodes, representing outgoing connections (edges) from the node.
;; * Meta: A placeholder for additional information associated with the node,
;;   this should not be considered part of the node itself.


(define-type9 olnode
  (olnode-constructor id value children meta) olnode?
  (id olnode:id)
  (value olnode:value)
  (children olnode:children olnode:children:set!)
  (meta olnode:meta olnode:meta:set!)
  )


;; OLNode utilizes a counter to ensure each node has a unique ID. This counter is incremented
;; for each new node created.


(define make-olnode/full
  (let ()
    (define counter 0)
    (lambda (value children meta)
      (define id counter)
      (set! counter (+ 1 counter))
      (olnode-constructor id value children meta))))


(define (make-olnode value)
  (define children '())
  (define meta #f)
  (make-olnode/full value children meta))


(define (olnode:prepend-child! parent child)
  (olnode:children:set! parent (cons child (olnode:children parent))))
