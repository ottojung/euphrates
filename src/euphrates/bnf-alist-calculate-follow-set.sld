
(define-library
  (euphrates bnf-alist-calculate-follow-set)
  (export bnf-alist:calculate-follow-set)
  (import
    (only (euphrates bnf-alist-calculate-first-set)
          bnf-alist:calculate-first-set))
  (import
    (only (euphrates bnf-alist-empty-huh)
          bnf-alist:empty?))
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
          if
          lambda
          let
          let*
          not
          null?
          or
          quote
          set!
          unless
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-calculate-follow-set.scm")))
    (else (include "bnf-alist-calculate-follow-set.scm"))))
