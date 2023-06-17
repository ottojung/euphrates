
(define-library
  (euphrates uni-spinlock)
  (export
    make-uni-spinlock
    uni-spinlock-lock!
    uni-spinlock-unlock!
    make-uni-spinlock-critical)
  (import
    (only (euphrates atomic-box)
          atomic-box-compare-and-set!
          atomic-box-set!
          make-atomic-box))
  (import
    (only (euphrates dynamic-thread-disable-cancel)
          dynamic-thread-disable-cancel))
  (import
    (only (euphrates dynamic-thread-enable-cancel)
          dynamic-thread-enable-cancel))
  (import
    (only (euphrates dynamic-thread-get-yield-procedure)
          dynamic-thread-get-yield-procedure))
  (import
    (only (scheme base)
          begin
          define-values
          lambda
          let
          let*
          unless
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/uni-spinlock.scm")))
    (else (include "uni-spinlock.scm"))))
