;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:lr-parsing-table:get-state-conflicts table state)
  (define actions-keys
    (parselynn:lr-parsing-table:action:list table state))

  (define (get-actions key)
    (define actions
      (parselynn:lr-parsing-table:action:ref table state key))

    (unless (pair? actions)
      (raisu-fmt 'type-error "Impossible. Expected a nonempty list."))

    (if (or (null? actions)
            (list-singleton? actions))
        #f
        (cons key actions)))

  (define conflicts
    (filter
     identity
     (map get-actions actions-keys)))

  conflicts)
