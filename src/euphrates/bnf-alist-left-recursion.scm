;;;; Copyright (C) 2025  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define-type9 <left-recursion>
  (bnf-alist:left-recursion:make nonterminal cycle)
  bnf-alist:left-recursion?
  (nonterminal bnf-alist:left-recursion:nonterminal)
  (cycle       bnf-alist:left-recursion:cycle))
