;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (list->join-semilattice
         equality-tester
         join-function
         lst)
  ;;
  ;;
  ;;
  ;; Let U : Type
  ;; Then
  ;; lst: List[U]
  ;; equality-tester: U, U -> boolean
  ;; join-function: \forall x,y,z \in U . x, y -> Union[z, void]
  ;; list->join-semilattice: ... -> olgraph[z]
  ;;
  ;; Where `void` is the type of `(values)` expression.
  ;;
  ;; Join returns either the join point of the two nodes,
  ;; or void in case there is no join between them.
  ;;

  TODO
  )
