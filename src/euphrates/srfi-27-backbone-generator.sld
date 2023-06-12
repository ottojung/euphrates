
(define-library
  (euphrates srfi-27-backbone-generator)
  (export
    mrg32k3a-pack-state
    mrg32k3a-unpack-state
    mrg32k3a-random-range
    mrg32k3a-random-integer
    mrg32k3a-random-real)
  (import
    (only (euphrates range) range)
    (only (scheme base)
          *
          +
          -
          <
          begin
          define
          do
          let
          let*
          modulo
          quotient
          vector-ref
          vector-set!))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/srfi-27-backbone-generator.scm")))
    (else (include "srfi-27-backbone-generator.scm"))))
