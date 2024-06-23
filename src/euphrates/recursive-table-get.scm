;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define recursive-table:get
  (case-lambda
   ((row-key)
    (define self
      (or (recursive-table/self/p)
          (raisu* :from "recursive-table:get"
                  :type 'not-inside-recursive-table
                  :message "Called recursive-table:get not from within a recursive table definition."
                  :args (list row-key))))

    (define matches
      (filter
       (lambda (row)
         (define other-thunk (car row))
         (define other (other-thunk))
         (equal? row-key other))
       self))

    (when (null? matches)
      (raisu* :from "recursive-table:get"
              :type 'bad-key
              :message (stringf "Could not find key ~s in the row keys." row-key)
              :args (list row-key self)))

    (let ()
      (define winner (car matches))
      (define winner-thunk (cadr winner))
      (define winner-value (winner-thunk))
      winner-value))

   ((column-key row-key)
    (define self
      (or (recursive-table/self/p)
          (raisu* :from "recursive-table:get"
                  :type 'not-inside-recursive-table
                  :message "Called recursive-table:get not from within a recursive table definition."
                  :args (list row-key))))

    (define valued-self/2
      (map (lambda (row)
             (cons ((car row)) (cdr row)))
           self))

    (define-pair (first-row rest)
      valued-self/2)

    (define-pair (upper-left columns-thunks)
      first-row)

    (define columns
      (map (lambda (thunk) (thunk))
           columns-thunks))

    (define valued-self
      (cons
       (cons upper-left columns)
       rest))

    (define found-thunk
      (annotated-table-assoc column-key row-key valued-self))

    (define found
      (found-thunk))

    found)

   ))
