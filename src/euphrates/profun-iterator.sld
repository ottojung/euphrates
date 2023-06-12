
(define-library
  (euphrates profun-iterator)
  (export
    profun-iterator-copy
    profun-iterator-insert!
    profun-iterator-reset!
    profun-iterator-constructor
    profun-iterator-db
    profun-iterator-env
    profun-iterator-state
    set-profun-iterator-state!
    profun-iterator-query
    set-profun-iterator-query!
    profun-abort-insert
    profun-abort-reset)
  (import
    (only (euphrates define-type9) define-type9)
    (only (euphrates profun-abort)
          profun-abort-additional
          profun-abort-iter)
    (only (euphrates profun-database)
          profun-database-copy
          profun-database-extend)
    (only (euphrates profun-env) profun-env-copy)
    (only (euphrates profun-error) make-profun-error)
    (only (euphrates profun-instruction)
          profun-instruction-arity
          profun-instruction-build/next
          profun-instruction-name)
    (only (euphrates profun-query-handle-underscores)
          profun-query-handle-underscores)
    (only (euphrates profun-state)
          profun-state-build
          profun-state-current
          profun-state-stack
          set-profun-state-current)
    (only (scheme base)
          begin
          car
          define
          if
          let
          null?
          symbol?
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-iterator.scm")))
    (else (include "profun-iterator.scm"))))
