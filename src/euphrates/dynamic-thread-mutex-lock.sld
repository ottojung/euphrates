
(define-library
  (euphrates dynamic-thread-mutex-lock)
  (export dynamic-thread-mutex-lock!)
  (import
    (only (euphrates dynamic-thread-mutex-lock-p-default)
          #{dynamic-thread-mutex-lock!#p-default}#)
    (only (euphrates dynamic-thread-mutex-lock-p)
          #{dynamic-thread-mutex-lock!#p}#)
    (only (scheme base) begin define or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-mutex-lock.scm")))
    (else (include "dynamic-thread-mutex-lock.scm"))))
