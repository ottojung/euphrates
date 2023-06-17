
(define-library
  (euphrates universal-lockr-unlockr)
  (export universal-lockr! universal-unlockr!)
  (import
    (only (euphrates dynamic-thread-get-delay-procedure)
          dynamic-thread-get-delay-procedure))
  (import
    (only (euphrates hashmap)
          hashmap-delete!
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates uni-spinlock)
          make-uni-spinlock-critical))
  (import
    (only (euphrates with-critical) with-critical))
  (import
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
