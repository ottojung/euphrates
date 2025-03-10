;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define-type9 parselynn:lr-state-graph
  (parselynn:lr-state-graph:constructor
   start ;; initial production of type `lenode?`.
   hash ;; mapping of state hashcode (type `string?`) to its state node (type `lenode?`).
   )

  parselynn:lr-state-graph?

  (start parselynn:lr-state-graph:start)
  (hash parselynn:lr-state-graph:hash)

  )


(define (parselynn:lr-state-graph:make start)
  (define hash (make-hashmap))

  (define start-node
    (lenode:make start))

  (define ret
    (parselynn:lr-state-graph:constructor
     start-node hash))

  (parselynn:lr-state-graph:add-node!
   ret start-node)

  ret)


(define (parselynn:lr-state-graph:add-node! graph node)
  (define hash
    (parselynn:lr-state-graph:hash graph))

  (define state
    (olnode:value node))

  (define key
    (parselynn:lr-state:serialize state))

  (define index
    (hashmap-count hash))

  (olnode:meta:set-value!
   node parselynn:lr-state-graph:node-id index)

  (hashmap-set! hash key node))


(define (parselynn:lr-state-graph:node-id lenode)
  (olnode:meta:get-value lenode parselynn:lr-state-graph:node-id))


(define (parselynn:lr-state-graph:add! graph source-state label target-state)
  (define hash
    (parselynn:lr-state-graph:hash graph))

  (define source-key
    (parselynn:lr-state:serialize source-state))

  (define source-node
    (hashmap-ref
     hash source-key
     (raisu* :from "parselynn:lr-state-graph:add!"
             :type 'cannot-find-source-node
             :message "Cannot find source node."
             :args (list graph source-state label target-state))))

  (define target-key
    (parselynn:lr-state:serialize target-state))

  (define existing-target-node
    (hashmap-ref hash target-key #f))

  (define target-node
    (or existing-target-node
        (let ()
          (define new (lenode:make target-state))
          (parselynn:lr-state-graph:add-node! graph new)
          new)))

  (lenode:add-child! source-node label target-node)

  (not existing-target-node))
