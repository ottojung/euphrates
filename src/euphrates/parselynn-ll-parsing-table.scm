;;;; Copyright (C) 2025  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define-type9 <ll-parsing-table-clause>
  (parselynn:ll-parsing-table-clause:make
   production candidates actions)

  parselynn:ll-parsing-table-clause?

  (production parselynn:ll-parsing-table-clause:production) ;; type is production.
  (candidates parselynn:ll-parsing-table-clause:candidates) ;; type is hashset of symbols.
  (actions parselynn:ll-parsing-table-clause:actions) ;; type is list of actions.

  )


(define-type9 <ll-parsing-table>
  (parselynn:ll-parsing-table:make
   starting-nonterminal ;; the first nonterminal that parsing starts from.
   clauses ;; a list of clauses.
   )

  parselynn:ll-parsing-table?

  (starting-nonterminal parselynn:ll-parsing-table:starting-nonterminal:raw)
  (clauses parselynn:ll-parsing-table:clauses)

  )


(define (parselynn:ll-parsing-table:starting-nonterminal table)
  (define clauses
    (parselynn:ll-parsing-table:clauses table))

  (when (null? clauses)
    (raisu-fmt
     'no-starting-nonterminal-172361
     "Parsing table does not have a starting nonterminal."))

  (parselynn:ll-parsing-table:starting-nonterminal:raw table))
