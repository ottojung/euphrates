
(define-library
  (euphrates fraction-to-radix3)
  (export fraction->radix3)
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates list-span-n) list-span-n))
  (import
    (only (euphrates radix3-parse-basevector)
          radix3:parse-basevector))
  (import
    (only (euphrates radix3) radix3-constructor))
  (import
    (only (scheme base)
          *
          -
          <
          abs
          append
          begin
          cons
          define
          define-values
          denominator
          if
          integer?
          length
          let
          list
          numerator
          quote
          quotient
          remainder
          reverse
          values
          vector-length
          zero?))
  (import (only (scheme r5rs) inexact->exact))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/fraction-to-radix3.scm")))
    (else (include "fraction-to-radix3.scm"))))
