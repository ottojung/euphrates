
(define-library
  (euphrates fraction-to-radix3)
  (export fraction->radix3)
  (import
    (only (euphrates alphanum-lowercase-alphabet)
          alphanum-lowercase/alphabet))
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates list-span-n) list-span-n))
  (import
    (only (euphrates radix3) radix3-constructor))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          *
          -
          <
          >
          abs
          append
          begin
          cond
          define
          define-values
          denominator
          else
          if
          inexact?
          integer?
          lambda
          length
          let
          list
          make-vector
          not
          number?
          numerator
          or
          quote
          quotient
          remainder
          values
          vector-copy
          vector-length
          vector-ref
          vector-set!
          vector?
          zero?))
  (import (only (scheme r5rs) inexact->exact))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/fraction-to-radix3.scm")))
    (else (include "fraction-to-radix3.scm"))))
