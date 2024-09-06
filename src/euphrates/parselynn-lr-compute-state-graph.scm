;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define (parselynn:lr-compute-state-graph bnf-alist)
  (define first-set
    (bnf-alist:compute-first-set bnf-alist))

  (parselynn:lr-compute-state-graph/given-first first-set bnf-alist))


(define (parselynn:lr-compute-state-graph/given-first first-set bnf-alist)
  (define initial-state
    (parselynn:lr-make-initial-state/given-first
     first-set bnf-alist))

  (define graph
    (parselynn:lr-state-graph:make initial-state))

  (let loop ((state initial-state))
    (define rec
      (parselynn:lr-state:collect-outgoing-states/given-first
       first-set bnf-alist state graph))

    (for-each loop rec))

  (unless (bnf-alist:empty? bnf-alist)
    (let ()
      (define start-symbol
        (bnf-alist:start-symbol bnf-alist))

      (define start-node
        (parselynn:lr-state-graph:start graph))

      (define final-node
        (lenode:get-child
         start-node start-symbol #f))

      (unless final-node
        (parselynn:lr-state-graph:add!
         graph initial-state start-symbol
         (parselynn:lr-state:make)))))

  graph)
