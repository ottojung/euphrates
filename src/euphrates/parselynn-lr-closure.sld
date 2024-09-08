
(define-library
  (euphrates parselynn-lr-closure)
  (export
    parselynn:lr-state:close!
    parselynn:lr-state:close!/given-first)
  (import
    (only (euphrates bnf-alist-assoc-productions)
          bnf-alist:assoc-productions))
  (import
    (only (euphrates bnf-alist-compute-first-set)
          bnf-alist:compute-first-set))
  (import
    (only (euphrates bnf-alist-nonterminals)
          bnf-alist:nonterminals))
  (import
    (only (euphrates bnf-alist-terminals)
          bnf-alist:terminals))
  (import
    (only (euphrates cartesian-each) cartesian-each))
  (import (only (euphrates comp) comp))
  (import
    (only (euphrates hashset)
          hashset-has?
          list->hashset))
  (import
    (only (euphrates parselynn-lr-item-next-lookaheads)
          parselynn:lr-item:next-lookaheads))
  (import
    (only (euphrates parselynn-lr-item)
          parselynn:lr-item:dot-at-end?
          parselynn:lr-item:make
          parselynn:lr-item:next-symbol))
  (import
    (only (euphrates parselynn-lr-state)
          parselynn:lr-state:add!
          parselynn:lr-state:foreach-item
          parselynn:lr-state:has?))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import
    (only (scheme base)
          begin
          define
          for-each
          lambda
          let
          unless
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-closure.scm")))
    (else (include "parselynn-lr-closure.scm"))))
