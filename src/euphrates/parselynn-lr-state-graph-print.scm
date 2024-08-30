;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define parselynn:lr-state-graph:print
  (case-lambda
   ((graph)
    (parselynn:lr-state-graph:print graph (current-output-port)))

   ((graph port)

    (parselynn:lr-state-graph:traverse
     graph
     (lambda (id state mapped-children)

       (define (show-transition mapped-child)
         (define-tuple (label child-id child) mapped-child)
         (display "    ")
         (display (object->string label))
         (display " -> ")
         (display (object->string child-id))
         (newline))

       (define (show-transitions)
         (for-each show-transition mapped-children))

       (display (object->string id))
       (display " = ")
       (parselynn:lr-state:print state)
       (newline)
       (show-transitions))))))
