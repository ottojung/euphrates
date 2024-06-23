;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (annotated-table-assoc column-key row-key table)
  (define first-row (car table))
  (define main-rows (cdr table))
  (define all-column-keys first-row)
  (define all-row-keys (map car main-rows))
  (define column-index
    (list-find-element-index column-key all-column-keys))
  (define row-index
    (list-find-element-index row-key all-row-keys))

  (unless row-index
    (raisu* :from "annotated-table-assoc-or"
            :type 'cannot-find-row-key
            :message (stringf "Could not find key ~s in the row keys." row-key)
            :args (list row-key table)))

  (unless column-index
    (raisu* :from "annotated-table-assoc-or"
            :type 'cannot-find-column-key
            :message (stringf "Could not find key ~s in the column keys." column-key)
            :args (list column-key table)))

  (let ()
    (define row
      (list-ref table (+ 1 row-index)))

    (define value
      (list-ref row column-index))

    value))
