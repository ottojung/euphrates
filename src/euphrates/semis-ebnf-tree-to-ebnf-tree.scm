;;;; Copyright (C) 2023  Otto Jung
;;;; This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; A "semis-ebnf-tree" is a "semi-structured EBNF tree" (where EBNF = Extended Backus-Naur Form).
;; It is semi-structured when there are terms whose structure
;;   is encoded in their names -
;;   for example a term "expr*" in semis-ebnf-tree
;;   is equivalent to "(* expr)" in ebnf-tree.
;; But the latter is more structured.
(define semis-ebnf-tree->ebnf-tree
  (let ()
    (define equality-symbol '=)
    (define alternation-symbol '/)
    (generic-semis-ebnf-tree->ebnf-tree equality-symbol alternation-symbol)))
