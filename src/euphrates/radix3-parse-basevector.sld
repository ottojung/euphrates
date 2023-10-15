
(define-library
  (euphrates radix3-parse-basevector)
  (export radix3:parse-basevector)
  (import
    (only (euphrates alphanum-lowercase-alphabet)
          alphanum-lowercase/alphabet))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          <
          >
          begin
          cond
          define
          else
          inexact?
          integer?
          lambda
          let
          list
          make-vector
          not
          number?
          or
          quote
          vector-copy
          vector-length
          vector-ref
          vector-set!
          vector?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/radix3-parse-basevector.scm")))
    (else (include "radix3-parse-basevector.scm"))))
