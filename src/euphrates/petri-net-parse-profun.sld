
(define-library
  (euphrates petri-net-parse-profun)
  (export petri-profun-net)
  (import
    (only (euphrates bool-to-profun-result)
          bool->profun-result))
  (import
    (only (euphrates hashmap) multi-alist->hashmap))
  (import
    (only (euphrates list-deduplicate)
          list-deduplicate))
  (import
    (only (euphrates petri-net-make) petri-net-make))
  (import (only (euphrates petri) petri-push))
  (import
    (only (euphrates profun-handler)
          profun-make-handler))
  (import
    (only (euphrates profun-op-apply)
          profun-op-apply))
  (import
    (only (euphrates profun-op-divisible)
          profun-op-divisible))
  (import
    (only (euphrates profun-op-eval) profun-op-eval))
  (import
    (only (euphrates profun-op-lambda)
          profun-op-lambda))
  (import
    (only (euphrates profun-op-less) profun-op-less))
  (import
    (only (euphrates profun-op-mult) profun-op*))
  (import
    (only (euphrates profun-op-plus) profun-op+))
  (import
    (only (euphrates profun-op-print)
          profun-op-print))
  (import
    (only (euphrates profun-op-separate)
          profun-op-separate))
  (import
    (only (euphrates profun-op-unify)
          profun-op-unify))
  (import
    (only (euphrates profun)
          profun-create-database
          profun-eval-query))
  (import (only (euphrates raisu) raisu))
  (import
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
          unquote-splicing))
  (import (only (scheme eval) eval))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/petri-net-parse-profun.scm")))
    (else (include "petri-net-parse-profun.scm"))))
