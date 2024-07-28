
(define-library
  (euphrates bnf-alist-compute-first-set)
  (export bnf-alist:compute-first-set)
  (import
    (only (euphrates bnf-alist-assoc-productions)
          bnf-alist:assoc-productions))
  (import
    (only (euphrates bnf-alist-epsilon)
          bnf:epsilon))
  (import
    (only (euphrates bnf-alist-for-each-production)
          bnf-alist:for-each-production))
  (import
    (only (euphrates bnf-alist-nonterminals)
          bnf-alist:nonterminals))
  (import
    (only (euphrates bnf-alist-terminals)
          bnf-alist:terminals))
  (import (only (euphrates comp) comp))
  (import
    (only (euphrates hashmap)
          alist->hashmap
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates hashset)
          hashset->list
          hashset-add!
          hashset-clear!
          hashset-foreach
          hashset-has?
          list->hashset
          make-hashset))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import
    (only (euphrates list-find-first)
          list-find-first))
  (import
    (only (scheme base)
          begin
          cond
          cons
          define
          else
          equal?
          for-each
          if
          lambda
          let
          list
          map
          or
          set!
          unless
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-compute-first-set.scm")))
    (else (include "bnf-alist-compute-first-set.scm"))))
