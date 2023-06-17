
(define-library
  (euphrates profun-op-plus)
  (export profun-op+)
  (import
    (only (euphrates profun-op-binary)
          profun-op-binary))
  (import
    (only (scheme base)
          +
          -
          /
          begin
          case
          define
          else
          lambda
          let
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-plus.scm")))
    (else (include "profun-op-plus.scm"))))
