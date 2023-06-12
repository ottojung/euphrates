
(define-library
  (euphrates profun-op-mult)
  (export profun-op*)
  (import
    (only (euphrates profun-op-binary)
          profun-op-binary)
    (only (scheme base)
          *
          /
          =
          and
          begin
          case
          define
          else
          integer?
          lambda
          let
          not
          quote)
    (only (scheme inexact) sqrt)
    (only (scheme r5rs) inexact->exact))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-mult.scm")))
    (else (include "profun-op-mult.scm"))))
