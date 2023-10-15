
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
          -
          /
          apply
          begin
          define
          expt
          if
          lambda
          make-string
          map
          string
          string->number
          string-append
          string-length
          vector-length
          vector-ref))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-null?)))
    (else (import (only (srfi 13) string-null?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/radix3-to-number.scm")))
    (else (include "radix3-to-number.scm"))))
