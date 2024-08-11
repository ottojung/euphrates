;;;; Copyright (C) 2024  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define (parselynn:lr-closure bnf-alist initial-item)
  (define first-set
    (bnf-alist:compute-first-set bnf-alist))

  (parselynn:lr-closure/given-first
   first-set bnf-alist initial-item))


(define (parselynn:lr-closure/given-first first-set bnf-alist initial-item)
  (define ret
    (parselynn:lr-state:make))

  (define terminals
    (list->hashset
     (bnf-alist:terminals bnf-alist)))

  (define nonterminals
    (list->hashset
     (bnf-alist:nonterminals bnf-alist)))

  (define (terminal? X)
    (hashset-has? terminals X))

  (define (nonterminal? X)
    (hashset-has? nonterminals X))

  (let loop ((item initial-item))
    (unless (parselynn:lr-state:has? ret item)
      (let ()

        (define _0
          (parselynn:lr-state:add! ret item))
        (define next
          (parselynn:lr-item:next-symbol item))

        (when (and next (nonterminal? next))
          (let ()
            (define productions
              (bnf-alist:assoc-productions next bnf-alist))

            (define lookaheads
              (parselynn:lr-item:next-lookaheads
               terminals nonterminals first-set item))

            (define new-items
              (cartesian-map
               (lambda (production lookahead)
                 (define lhs next)
                 (define rhs production)

                 (parselynn:lr-item:make
                  lhs rhs lookahead))

               productions
               lookaheads))

            (for-each loop new-items))))))

  ret)
