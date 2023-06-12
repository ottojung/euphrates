
(define-library
  (euphrates profun-op-function)
  (export profun-op-function)
  (import
    (only (euphrates identity) identity)
    (only (euphrates list-singleton-q)
          list-singleton?)
    (only (euphrates list-span-n) list-span-n)
    (only (euphrates profun-accept)
          profun-accept
          profun-set)
    (only (euphrates profun-answer-huh)
          profun-answer?)
    (only (euphrates profun-error) make-profun-error)
    (only (euphrates profun-op) make-profun-op)
    (only (euphrates profun-reject) profun-reject)
    (only (euphrates profun-request-value)
          profun-request-value)
    (only (euphrates profun-value)
          profun-bound-value?
          profun-unbound-value?
          profun-value-unwrap)
    (only (euphrates raisu) raisu)
    (only (scheme base)
          +
          =
          _
          and
          apply
          begin
          call-with-values
          car
          cdr
          cond
          cons
          define
          define-syntax
          define-values
          else
          equal?
          if
          lambda
          length
          let
          list
          map
          not
          null?
          number?
          procedure?
          quote
          syntax-rules
          unless)
    (only (srfi srfi-1) filter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-function.scm")))
    (else (include "profun-op-function.scm"))))
