
(define-library
  (euphrates profun-op-value)
  (export profun-op-value)
  (import
    (only (euphrates profun-CR) make-profun-CR))
  (import
    (only (euphrates profun-accept)
          profun-accept
          profun-set))
  (import
    (only (euphrates profun-answer-join)
          profun-answer-join/and
          profun-answer-join/any
          profun-answer-join/or))
  (import
    (only (euphrates profun-op-envlambda)
          profun-op-envlambda))
  (import
    (only (euphrates profun-reject) profun-reject))
  (import
    (only (euphrates profun-value)
          profun-bound-value?
          profun-unbound-value?
          profun-value-name))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          and
          assq
          begin
          car
          case
          cdr
          cond
          define
          else
          if
          let
          let*
          list?
          null?
          or
          pair?
          quote
          symbol?))
  (cond-expand
    (guile (import (only (srfi srfi-1) any)))
    (else (import (only (srfi 1) any))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-value.scm")))
    (else (include "profun-op-value.scm"))))
