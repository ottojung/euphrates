
(define-library
  (euphrates profun-op-value)
  (export profun-op-value)
  (import
    (only (euphrates profun-CR) make-profun-CR)
    (only (euphrates profun-accept)
          profun-accept
          profun-set)
    (only (euphrates profun-answer-join)
          profun-answer-join/and
          profun-answer-join/any
          profun-answer-join/or)
    (only (euphrates profun-op-envlambda)
          profun-op-envlambda)
    (only (euphrates profun-reject) profun-reject)
    (only (euphrates profun-value)
          profun-bound-value?
          profun-unbound-value?
          profun-value-name)
    (only (euphrates raisu) raisu)
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
          symbol?)
    (only (srfi srfi-1) any))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-value.scm")))
    (else (include "profun-op-value.scm"))))
