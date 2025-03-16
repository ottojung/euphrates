;;;; Copyright (C) 2025  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (bnf-alist:find-left-recursion bnf-alist)
  (define reachability
    (bnf-alist:compute-reachability bnf-alist))

  (define nonterminals
    (bnf-alist:nonterminals bnf-alist))

  (define (recursive? nonterminal)
    (define reachable
      (hashmap-ref reachability nonterminal))

    (hashset-has? reachable nonterminal))

  (define recursive-nonterminals
    (filter recursive? nonterminals))

  (define (recursive-path? path)
    (member (car path) (cdr path)))

  (define (make-recursion-structs nonterminal)
    (define all-paths
      (bnf-alist:compute-all-paths-from bnf-alist nonterminal))

    (define cycles
      (filter recursive-path? all-paths))

    (define (make-single-recursion-struct cycle)
      (bnf-alist:left-recursion:make nonterminal cycle))

    (map make-single-recursion-struct cycles))

  (define structures
    (list-map/flatten make-recursion-structs recursive-nonterminals))

  structures)
