;;;; Copyright (C) 2025  Otto Jung
;;;; This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; version 3 of the License. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


(define (parselynn:ll-compute-parsing-table bnf-alist)
  (define first-set
    (bnf-alist:compute-first-set bnf-alist))
  (define follow-set
    (bnf-alist:compute-follow-set bnf-alist))

  (parselynn:ll-compute-parsing-table/given-sets first-set follow-set bnf-alist))


(define (parselynn:ll-compute-parsing-table/given-sets
         first-set follow-set bnf-alist)

  (define clauses-stack
    (stack-make))
  (define empty-set
    (make-hashset))

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

  (define starting-nonterminal
    (if (null? bnf-alist) #f
        (bnf-alist:start-symbol bnf-alist)))

  (define (get-first nonterminal alpha)
    (define follow
      (hashmap-ref follow-set nonterminal empty-set))

    (parselynn:hashmap-ref/epsilon-aware
     terminals nonterminals first-set
     (append alpha (list follow))))

  (define (handle-symbol nonterminal symbol)
    (cond
     ((terminal? symbol)
      (parselynn:ll-match-action:make symbol))

     ((nonterminal? symbol)
      (parselynn:ll-predict-action:make symbol))

     (else
      (raisu-fmt
       'bad-type-of-thing-61351253751412937
       "Expected a terminal or a nonterminal, but got %s."
       symbol))))

  (define (handle-alpha nonterminal alpha)
    (define production
      (bnf-alist:production:make nonterminal alpha))
    (define candidates
      (get-first nonterminal alpha))
    (define actions
      (map (comp (handle-symbol nonterminal)) alpha))
    (define clause
      (parselynn:ll-parsing-table-clause:make
       production candidates actions))

    (stack-push! clauses-stack clause))

  (define (handle-production nonterminal)
    (lambda (alpha)
      (handle-alpha nonterminal alpha)))

  (bnf-alist:for-each-production handle-production bnf-alist)

  (parselynn:ll-parsing-table:make
   starting-nonterminal
   (reverse (stack->list clauses-stack))))
