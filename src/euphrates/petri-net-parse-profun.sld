
(define-library
  (euphrates petri-net-parse-profun)
  (export petri-profun-net)
  (import
    (only (euphrates bool-to-profun-result)
          bool->profun-result)
    (only (euphrates hashmap) multi-alist->hashmap)
    (only (euphrates list-deduplicate)
          list-deduplicate)
    (only (euphrates petri-net-make) petri-net-make)
    (only (euphrates petri) petri-push)
    (only (euphrates profun-handler)
          profun-make-handler)
    (only (euphrates profun-op-apply)
          profun-op-apply)
    (only (euphrates profun-op-divisible)
          profun-op-divisible)
    (only (euphrates profun-op-eval) profun-op-eval)
    (only (euphrates profun-op-lambda)
          profun-op-lambda)
    (only (euphrates profun-op-less) profun-op-less)
    (only (euphrates profun-op-mult) profun-op*)
    (only (euphrates profun-op-plus) profun-op+)
    (only (euphrates profun-op-print)
          profun-op-print)
    (only (euphrates profun-op-separate)
          profun-op-separate)
    (only (euphrates profun-op-unify)
          profun-op-unify)
    (only (euphrates profun)
          profun-create-database
          profun-eval-query)
    (only (euphrates raisu) raisu)
    (only (scheme base)
          *
          +
          <
          =
          and
          apply
          begin
          car
          cdr
          cons
          define
          lambda
          length
          let
          map
          not
          pair?
          quasiquote
          quote
          string->symbol
          string?
          unless
          unquote
          unquote-splicing)
    (only (scheme eval) eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/petri-net-parse-profun.scm")))
    (else (include "petri-net-parse-profun.scm"))))
