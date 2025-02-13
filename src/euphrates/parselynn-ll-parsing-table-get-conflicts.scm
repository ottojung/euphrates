;;;; Copyright (C) 2025  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

(define (parselynn:ll-parsing-table:get-conflicts parsing-table)
  (define clauses
    (parselynn:ll-parsing-table:clauses parsing-table))

  (define (grouper clause)
    (define production
      (parselynn:ll-parsing-table-clause:production clause))
    (define nonterminal
      (bnf-alist:production:lhs production))

    nonterminal)

  (define grouped-clauses
    (list-group-by grouper clauses))

  (define (handle-candidate hash production candidate)
    (define default '())
    (define existing (hashmap-ref hash candidate default))
    (define new (cons production existing))
    (hashmap-set! hash candidate new))

  (define (handle-clause hash clause)
    (define production
      (parselynn:ll-parsing-table-clause:production clause))
    (define candidates
      (parselynn:ll-parsing-table-clause:candidates clause))

    (hashset-foreach (comp (handle-candidate hash production)) candidates))

  (define (handle-hash hash)
    (define alist (hashmap->alist hash))
    (define filtered
      (filter (lambda (p)
                (define candidate (car p))
                (define productions (cdr p))
                (< 1 (length productions)))
              alist))
    (define sorted
      (euphrates:list-sort
       filtered (lambda (a b)
                  (string<? (~s a) (~s b)))))
    (if (null? sorted) '()
        sorted))

  (define (handle-group tagged-group)
    (define nonterminal (car tagged-group))
    (define clauses (cdr tagged-group))
    (define hash (make-hashmap))
    (for-each (comp (handle-clause hash)) clauses)
    (handle-hash hash))

  (define collected
    (list-map/flatten handle-group grouped-clauses))

  (define (wrap-production production)
    (parselynn:ll-choose-action:make production))

  (define (wrap-conflict conflict)
    (define candidate (car conflict))
    (define productions (cdr conflict))
    (define nonterminal
      (bnf-alist:production:lhs (car productions)))
    (list nonterminal (cons candidate (map wrap-production productions))))

  (define wraped
    (map wrap-conflict collected))

  (define result
    wraped)

  result)
