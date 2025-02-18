
(define-library
  (euphrates bnf-alist-compute-reachability)
  (export bnf-alist:compute-reachability)
  (import
    (only (euphrates bnf-alist-for-each-production)
          bnf-alist:for-each-production))
  (import
    (only (euphrates bnf-alist-nonterminals)
          bnf-alist:nonterminals))
  (import (only (euphrates comp) comp))
  (import
    (only (euphrates compose-under) compose-under))
  (import
    (only (euphrates hashmap)
          alist->hashmap
          hashmap-foreach
          hashmap-ref))
  (import
    (only (euphrates hashset)
          hashset-add!
          hashset-foreach
          hashset-has?
          make-hashset))
  (import (only (euphrates identity) identity))
  (import (only (euphrates thunk) thunk))
  (import
    (only (scheme base)
          begin
          cons
          define
          for-each
          lambda
          let
          map
          set!
          unless
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-compute-reachability.scm")))
    (else (include "bnf-alist-compute-reachability.scm"))))
