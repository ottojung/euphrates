
(define-library
  (euphrates profun-op-function)
  (export profun-op-function)
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates list-singleton-q)
          list-singleton?))
  (import
    (only (euphrates list-span-n) list-span-n))
  (import
    (only (euphrates profun-accept)
          profun-accept
          profun-set))
  (import
    (only (euphrates profun-answer-huh)
          profun-answer?))
  (import
    (only (euphrates profun-error) make-profun-error))
  (import
    (only (euphrates profun-op) make-profun-op))
  (import
    (only (euphrates profun-reject) profun-reject))
  (import
    (only (euphrates profun-request-value)
          profun-request-value))
  (import
    (only (euphrates profun-value)
          profun-bound-value?
          profun-unbound-value?
          profun-value-unwrap))
  (import (only (euphrates raisu) raisu))
  (import
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
          unless))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-function.scm")))
    (else (include "profun-op-function.scm"))))
