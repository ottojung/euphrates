
(define-library
  (euphrates uni-critical)
  (export uni-critical-make)
  (import
    (only (euphrates dynamic-thread-disable-cancel-p)
          #{dynamic-thread-disable-cancel#p}#)
    (only (euphrates dynamic-thread-enable-cancel-p)
          #{dynamic-thread-enable-cancel#p}#)
    (only (euphrates dynamic-thread-mutex-lock-p)
          #{dynamic-thread-mutex-lock!#p}#)
    (only (euphrates dynamic-thread-mutex-make)
          dynamic-thread-mutex-make)
    (only (euphrates dynamic-thread-mutex-unlock-p)
          #{dynamic-thread-mutex-unlock!#p}#)
    (only (scheme base)
          apply
          begin
          call-with-values
          define
          lambda
          let*
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/uni-critical.scm")))
    (else (include "uni-critical.scm"))))
