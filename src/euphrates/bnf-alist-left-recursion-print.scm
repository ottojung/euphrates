;;;; Copyright (C) 2025  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define bnf-alist:left-recursion:print
  (case-lambda
   ((obj)
    (bnf-alist:left-recursion:print obj (current-output-port)))
   ((obj port)
    (fprintf port
             "Left recursion detected in nonterminal ~s. The nullable cycle is: ~a"
             (~a (bnf-alist:left-recursion:nonterminal obj))
             (words->string (map ~s (bnf-alist:left-recursion:cycle obj)))))))
