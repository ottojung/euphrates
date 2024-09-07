;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:lr-compute-parsing-table bnf-alist callback-alist)
  (define first-set
    (bnf-alist:compute-first-set bnf-alist))

  (parselynn:lr-compute-parsing-table/given-first first-set bnf-alist callback-alist))


(define (parselynn:lr-compute-parsing-table/given-first first-set bnf-alist callback-alist)
  (define graph
    (parselynn:lr-compute-state-graph/given-first first-set bnf-alist))

  (parselynn:lr-state-graph->lr-parsing-table bnf-alist callback-alist graph))
