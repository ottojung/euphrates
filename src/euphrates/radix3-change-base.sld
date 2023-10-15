
(define-library
  (euphrates radix3-change-base)
  (export radix3:change-base)
  (import
    (only (euphrates number-to-radix3)
          number->radix3))
  (import
    (only (euphrates radix3-parse-basevector)
          radix3:parse-basevector))
  (import
    (only (euphrates radix3-to-number)
          radix3->number))
  (import
    (only (euphrates radix3)
          radix3-constructor
          radix3:basevector
          radix3:fracpart
          radix3:intpart
          radix3:period
          radix3:sign))
  (import
    (only (scheme base)
          =
          begin
          define
          if
          vector-length))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/radix3-change-base.scm")))
    (else (include "radix3-change-base.scm"))))
