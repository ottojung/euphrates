
(define-library
  (euphrates profun-handler)
  (export
    profun-make-handler
    profun-handler-get
    profun-handler-extend)
  (import
    (only (euphrates hashmap)
          hashmap-merge
          hashmap-ref
          multi-alist->hashmap))
  (import
    (only (euphrates list-find-first)
          list-find-first))
  (import
    (only (euphrates profun-op-obj) profun-op-arity))
  (import
    (only (euphrates profun-variable-arity-op-huh)
          profun-variable-arity-op?))
  (import
    (only (scheme base)
          =
          _
          begin
          cons
          define
          define-syntax
          lambda
          let
          or
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-handler.scm")))
    (else (include "profun-handler.scm"))))
