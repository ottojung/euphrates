
(define-library
  (euphrates bnf-alist-compute-all-paths-from)
  (export bnf-alist:compute-all-paths-from)
  (import
    (only (euphrates bnf-alist-nonterminals)
          bnf-alist:nonterminals))
  (import
    (only (euphrates hashset)
          hashset-has?
          list->hashset))
  (import
    (only (euphrates parselynn-epsilon)
          parselynn:epsilon))
  (import
    (only (scheme base)
          and
          append
          apply
          assoc
          begin
          car
          cdr
          cons
          define
          if
          lambda
          let
          let*
          list
          map
          member
          null?
          quote))
  (cond-expand
    (guile (import (only (srfi srfi-1) first)))
    (else (import (only (srfi 1) first))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-compute-all-paths-from.scm")))
    (else (include "bnf-alist-compute-all-paths-from.scm"))))
