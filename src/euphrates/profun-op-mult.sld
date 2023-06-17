
(define-library
  (euphrates profun-op-mult)
  (export profun-op*)
  (import
    (only (euphrates profun-op-binary)
          profun-op-binary))
  (import
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
          quote))
  (import (only (scheme inexact) sqrt))
  (import (only (scheme r5rs) inexact->exact))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-mult.scm")))
    (else (include "profun-op-mult.scm"))))
