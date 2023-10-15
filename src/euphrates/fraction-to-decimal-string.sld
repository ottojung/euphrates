
(define-library
  (euphrates fraction-to-decimal-string)
  (export
    fraction->decimal-string
    fraction->decimal-string/tuples)
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates list-span-n) list-span-n))
  (import
    (only (scheme base)
          *
          -
          append
          apply
          begin
          define
          define-values
          denominator
          if
          length
          let
          list
          number->string
          numerator
          quotient
          remainder
          set!
          string-append
          unless
          zero?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/fraction-to-decimal-string.scm")))
    (else (include "fraction-to-decimal-string.scm"))))
