;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;
;; This procedure computes the closure of a given LR(1) item for a context-free grammar.
;; The closure of an LR(1) item encompasses all the items that can be derived directly
;; or indirectly from that item. Specifically, for a given LR(1) item [A -> alpha • B beta, a],
;; where A -> alpha • B beta is a production with a dot (•) marking the current position
;; in the production, and 'a' is a lookahead terminal.
;;

;;
;; Given a context-free grammar G = (N, T, P, S):
;; - N is the set of non-terminals,
;; - T is the set of terminals,
;; - P is the set of production rules,
;; - S is the start symbol.
;;
;; The "closure" of an item can be defined as follows:
;;
;; 1. **Initialization:**
;;    - Start with a given initial item, say [A -> alpha • B beta, a].
;;    - If the item has a non-terminal B right after the dot (•), this non-terminal needs further expansion.
;;
;; 2. **Expansion:**
;;    For each item in the closure:
;;    - If the dot (•) is immediately before a non-terminal B,
;;      - For each production rule B -> gamma in the grammar,
;;        - Create new items [B -> • gamma, b] for all possible lookahead symbols 'b'
;;          derived from the first set of (beta a).
;;        - Add these new items to the closure if they are not already present.
;;
;; 3. **Fixpoint:**
;;    - Repeat the process of adding new items until no more new items can be added.
;;


(define (parselynn:lr-closure bnf-alist initial-item)
  (define first-set
    ;; Compute the first set of the grammar, which is essential for closure computation.
    (bnf-alist:compute-first-set bnf-alist))

  ;; Compute the closure given the precomputed first sets.
  (parselynn:lr-closure/given-first
   first-set bnf-alist initial-item))


(define (parselynn:lr-closure/given-first first-set bnf-alist initial-item)
  ;; Create an empty state to store the closure.
  (define ret
    (parselynn:lr-state:make))

  ;; Convert terminals and nonterminals to hash sets for easy membership testing.
  (define terminals
    (list->hashset
     (bnf-alist:terminals bnf-alist)))

  (define nonterminals
    (list->hashset
     (bnf-alist:nonterminals bnf-alist)))

  ;; Define utility functions to check if a symbol is terminal or nonterminal.
  (define (terminal? X)
    (hashset-has? terminals X))

  (define (nonterminal? X)
    (hashset-has? nonterminals X))

  ;; Recursive function to compute the closure.
  (let loop ((item initial-item))
    (unless (parselynn:lr-state:has? ret item)
      (let ()
        ;; Add the item to the closure state.
        (define _0
          (parselynn:lr-state:add! ret item))

        ;; Get the next symbol after the dot (•) in the item.
        (define next
          (parselynn:lr-item:next-symbol item))

        ;; If the next symbol is a non-terminal, expand the closure.
        (when (and next (nonterminal? next))
          (let ()
            ;; Get all productions for the non-terminal.
            (define productions
              (bnf-alist:assoc-productions next bnf-alist))

            ;; Compute lookahead symbols for new items derived from the current item.
            (define lookaheads
              (parselynn:lr-item:next-lookaheads
               terminals nonterminals first-set item))

            ;; Generate new items by combining productions and lookaheads.
            (define new-items
              (cartesian-map
               (lambda (production lookahead)
                 (define lhs next)
                 (define rhs production)

                 ;; Create a new LR(1) item with the production and lookahead.
                 (parselynn:lr-item:make
                  lhs rhs lookahead))

               productions
               lookaheads))

            ;; Recursively process the new items to further expand the closure.
            (for-each loop new-items))))))

  ;; Return the computed closure state.
  ret)
