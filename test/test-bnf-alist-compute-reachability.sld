
(define-library
  (test-bnf-alist-compute-reachability)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates bnf-alist-compute-reachability)
          bnf-alist:compute-reachability))
  (import (only (euphrates debug) debug))
  (import
    (only (euphrates euphrates-list-sort)
          euphrates:list-sort))
  (import
    (only (euphrates hashmap) hashmap-foreach))
  (import (only (euphrates hashset) hashset->list))
  (import (only (euphrates tilda-a) ~a))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (scheme base)
          _
          begin
          car
          cdr
          cons
          define
          define-syntax
          equal?
          lambda
          let
          map
          quasiquote
          quote
          set!
          string<?
          syntax-rules
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-bnf-alist-compute-reachability.scm")))
    (else (include
            "test-bnf-alist-compute-reachability.scm"))))
