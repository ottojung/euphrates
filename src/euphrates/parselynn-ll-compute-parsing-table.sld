
(define-library
  (euphrates parselynn-ll-compute-parsing-table)
  (export parselynn:ll-compute-parsing-table)
  (import
    (only (euphrates bnf-alist-compute-first-set)
          bnf-alist:compute-first-set))
  (import
    (only (euphrates bnf-alist-compute-follow-set)
          bnf-alist:compute-follow-set))
  (import
    (only (euphrates bnf-alist-for-each-production)
          bnf-alist:for-each-production))
  (import
    (only (euphrates bnf-alist-nonterminals)
          bnf-alist:nonterminals))
  (import
    (only (euphrates bnf-alist-production-make)
          bnf-alist:production:make))
  (import
    (only (euphrates bnf-alist-start-symbol)
          bnf-alist:start-symbol))
  (import
    (only (euphrates bnf-alist-terminals)
          bnf-alist:terminals))
  (import (only (euphrates comp) comp))
  (import (only (euphrates hashmap) hashmap-ref))
  (import
    (only (euphrates hashset)
          hashset-has?
          list->hashset
          make-hashset))
  (import
    (only (euphrates parselynn-hashmap-ref-epsilon-aware)
          parselynn:hashmap-ref/epsilon-aware))
  (import
    (only (euphrates parselynn-ll-match-action)
          parselynn:ll-match-action:make))
  (import
    (only (euphrates parselynn-ll-parsing-table)
          parselynn:ll-parsing-table-clause:make
          parselynn:ll-parsing-table:make))
  (import
    (only (euphrates parselynn-ll-predict-action)
          parselynn:ll-predict-action:make))
  (import (only (euphrates raisu-fmt) raisu-fmt))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import
    (only (scheme base)
          append
          begin
          cond
          define
          else
          if
          lambda
          list
          map
          null?
          quote
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-ll-compute-parsing-table.scm")))
    (else (include
            "parselynn-ll-compute-parsing-table.scm"))))
