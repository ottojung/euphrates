
(define-library
  (euphrates profun-op-binary)
  (export profun-op-binary)
  (import
    (only (euphrates bool-to-profun-result)
          bool->profun-result)
    (only (euphrates profun-accept) profun-set)
    (only (euphrates profun-op-lambda)
          profun-op-lambda)
    (only (euphrates profun-request-value)
          profun-request-value)
    (only (euphrates profun-value)
          profun-bound-value?)
    (only (scheme base)
          =
          >=
          and
          begin
          cond
          define
          else
          equal?
          if
          integer?
          let
          quasiquote
          quote
          unquote)
    (only (srfi srfi-1) any))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-binary.scm")))
    (else (include "profun-op-binary.scm"))))
