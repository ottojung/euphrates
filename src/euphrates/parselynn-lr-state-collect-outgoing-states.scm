;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define (parselynn:lr-state:collect-outgoing-states
         bnf-alist state graph)

  (define first-set
    (bnf-alist:compute-first-set bnf-alist))

  (parselynn:lr-state:collect-outgoing-states/given-first
   first-set bnf-alist state graph))


(define (parselynn:lr-state:collect-outgoing-states/given-first
         first-set bnf-alist state graph)

  (define next-symbols
    (parselynn:lr-state:next-symbols state))

  (hashset-foreach

   (lambda (next-symbol)
     (define next-state
       (parselynn:lr-goto/given-first first-set state next-symbol bnf-alist))

     (parselynn:lr-state-graph:add!
      graph state next-symbol next-state))

   next-symbols)

  (values))
