;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:lr-parsing-table:get-conflicts table)
  (define states
    (parselynn:lr-parsing-table:state:keys table))

  (define (get-state-conflicts state)
    (define conflicts
      (parselynn:lr-parsing-table:get-state-conflicts table state))

    (if (null? conflicts) '()
        (cons state conflicts)))

  (filter
   (negate null?)
   (map
    get-state-conflicts
    states)))
