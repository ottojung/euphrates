
(define-library
  (euphrates np-thread-parameterize)
  (export
    np-thread-parameterize-env
    with-np-thread-env/non-interruptible)
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
    (only (euphrates fn) fn)
    (only (euphrates make-unique) make-unique)
    (only (euphrates np-thread) np-thread-make-env)
    (only (euphrates universal-lockr-unlockr)
          universal-lockr!
          universal-unlockr!)
    (only (euphrates universal-usleep)
          universal-usleep)
    (only (scheme base)
          _
          begin
          define
          define-syntax
          define-values
          lambda
          parameterize
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/np-thread-parameterize.scm")))
    (else (include "np-thread-parameterize.scm"))))
