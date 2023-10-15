
(define-library
  (euphrates radix3-to-number)
  (export radix3->number)
  (import
    (only (euphrates radix3)
          radix3:basevector
          radix3:fracpart
          radix3:intpart
          radix3:period
          radix3:sign))
  (import
    (only (scheme base)
          *
          +
          -
          /
          append
          begin
          car
          cdr
          define
          expt
          if
          length
          let
          null?
          reverse
          vector-length))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/radix3-to-number.scm")))
    (else (include "radix3-to-number.scm"))))
