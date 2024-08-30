;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:lr-state-graph:traverse graph function)
  (define start (parselynn:lr-state-graph:start graph))
  (define recset (make-hashset))

  (let loop ((current start))

    (define id (parselynn:lr-state-graph:node-id current))
    (define state (olnode:value current))

    (unless (hashset-has? recset id)
      (hashset-add! recset id)
      (let ()
        (define children-labels
          (lenode:labels current))
        (define children
          (map (comp (lenode:get-child current)) children-labels))
        (define children-states
          (map olnode:value children))
        (define children-ids
          (map parselynn:lr-state-graph:node-id children))
        (define mapped-children
          (map list children-labels children-ids children-states))

        (function id state mapped-children)

        (for-each loop children)))))
