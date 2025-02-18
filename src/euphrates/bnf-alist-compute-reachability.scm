;;;; Copyright (C) 2025  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (bnf-alist:compute-reachability bnf-alist)
  (define nonterminals
    (bnf-alist:nonterminals bnf-alist))

  ;; Build an hashmap from each nonterminal in the grammar
  ;; to a new (empty) hashset.
  (define mapping
    (alist->hashmap
     (map
      (compose-under cons identity (lambda _ (make-hashset)))
      nonterminals)))

  ;; Phase 1: For every production of each nonterminal, add each symbol
  ;; (if it appears as a key in mapping) to that nonterminal's direct reachability.
  (bnf-alist:for-each-production
   (lambda (lhs)
     (define reachable-set (hashmap-ref mapping lhs))
     (lambda (rhs)
       (for-each (comp (hashset-add! reachable-set)) rhs)))
   bnf-alist)

  ;; Phase 2: Propagate reachability across nonterminals until no changes occur.
  (let fixpoint ()
    (define changed #f)

    (define (handle-mapping nonterminal reachable-set)
      (hashset-foreach

       (lambda (y)
         (define reachable-from-y
           (hashmap-ref mapping y #f))

         (when reachable-from-y
           (hashset-foreach
            (lambda (z)
              (unless (hashset-has? reachable-set z)
                (hashset-add! reachable-set z)
                (set! changed #t)))
            reachable-from-y)))

       reachable-set))

    (hashmap-foreach handle-mapping mapping)

    (when changed (fixpoint)))

  mapping)
