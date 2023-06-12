
(define-library
  (euphrates with-singlethread-env)
  (export with-singlethread-env)
  (import
    (only (euphrates dynamic-thread-cancel-p)
          #{dynamic-thread-cancel#p}#)
    (only (euphrates dynamic-thread-critical-make-p)
          #{dynamic-thread-critical-make#p}#)
    (only (euphrates dynamic-thread-disable-cancel-p)
          #{dynamic-thread-disable-cancel#p}#)
    (only (euphrates dynamic-thread-enable-cancel-p)
          #{dynamic-thread-enable-cancel#p}#)
    (only (euphrates dynamic-thread-mutex-lock-p)
          #{dynamic-thread-mutex-lock!#p}#)
    (only (euphrates dynamic-thread-mutex-make-p)
          #{dynamic-thread-mutex-make#p}#)
    (only (euphrates dynamic-thread-mutex-unlock-p)
          #{dynamic-thread-mutex-unlock!#p}#)
    (only (euphrates dynamic-thread-sleep-p)
          #{dynamic-thread-sleep#p}#)
    (only (euphrates dynamic-thread-spawn-p)
          #{dynamic-thread-spawn#p}#)
    (only (euphrates dynamic-thread-yield-p)
          #{dynamic-thread-yield#p}#)
    (only (euphrates sys-usleep) sys-usleep)
    (only (scheme base)
          _
          begin
          define-syntax
          lambda
          let
          parameterize
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/with-singlethread-env.scm")))
    (else (include "with-singlethread-env.scm"))))
