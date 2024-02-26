;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define-type9 olgraph
  (make-olgraph initial) olgraph?
  (initial olgraph:initial olgraph:initial:set!)
  )


                                        ; OLNODE

                                        ; Each Olnode represents a node in the graph, and includes several properties:
                                        ; * ID: A unique identifier for the node. This is used for efficient equality checks.
                                        ; * Value: This represents the value or data held in the node.
                                        ; * Children: List of Olnodes, representing outgoing connections (edges) from the node. 
                                        ; * Meta: A placeholder for additional information associated with the node,
                                        ;   this should not be considered part of the node itself.

                                        ; Olnode utilizes a counter to ensure each node has a unique ID. This counter is incremented 
                                        ; for each new node created.


(define-type9 olnode
  (olnode-constructor id value children meta) olnode?
  (id olnode:id)
  (value olnode:value)
  (children olnode:children olnode:children:set!)
  (meta olnode:meta olnode:meta:set!)
  )


(define make-olnode
  (let ()
    (define counter 0)
    (lambda (value children meta)
      (define id counter)
      (set! counter (+ 1 counter))
      (olnode-constructor id value children meta))))
