
(define-library
  (euphrates bnf-alist-compute-follow-set)
  (export
    bnf-alist:compute-follow-set
    bnf-alist:compute-follow-set/given-first)
  (import
    (only (euphrates bnf-alist-assoc-productions)
          bnf-alist:assoc-productions))
  (import
    (only (euphrates bnf-alist-compute-first-set)
          bnf-alist:compute-first-set))
  (import
    (only (euphrates bnf-alist-empty-huh)
          bnf-alist:empty?))
  (import
    (only (euphrates bnf-alist-end-of-input)
          bnf-alist:end-of-input))
  (import
    (only (euphrates bnf-alist-epsilon)
          bnf-alist:epsilon))
  (import
    (only (euphrates bnf-alist-for-each-production)
          bnf-alist:for-each-production))
  (import
    (only (euphrates bnf-alist-nonterminals)
          bnf-alist:nonterminals))
  (import
    (only (euphrates bnf-alist-start-symbol)
          bnf-alist:start-symbol))
  (import
    (only (euphrates bnf-alist-terminals)
          bnf-alist:terminals))
  (import (only (euphrates comp) comp))
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates hashset)
          hashset-add!
          hashset-clear!
          hashset-foreach
          hashset-has?
          list->hashset
          make-hashset))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import
    (only (scheme base)
          and
          begin
          car
          cdr
          cond
          define
          equal?
          for-each
          if
          lambda
          let
          let*
          null?
          or
          set!
          unless
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-compute-follow-set.scm")))
    (else (include "bnf-alist-compute-follow-set.scm"))))
