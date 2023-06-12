
(define-library
  (euphrates universal-lockr-unlockr)
  (export universal-lockr! universal-unlockr!)
  (import
    (only (euphrates dynamic-thread-get-delay-procedure)
          dynamic-thread-get-delay-procedure)
    (only (euphrates hashmap)
          hashmap-delete!
          hashmap-ref
          hashmap-set!
          make-hashmap)
    (only (euphrates uni-spinlock)
          make-uni-spinlock-critical)
    (only (euphrates with-critical) with-critical)
    (only (scheme base)
          begin
          define-values
          if
          lambda
          let
          values
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/universal-lockr-unlockr.scm")))
    (else (include "universal-lockr-unlockr.scm"))))
