
(define-library
  (euphrates dynamic-thread-mutex-unlock)
  (export dynamic-thread-mutex-unlock!)
  (import
    (only (euphrates dynamic-thread-mutex-unlock-p-default)
          #{dynamic-thread-mutex-unlock!#p-default}#))
  (import
    (only (euphrates dynamic-thread-mutex-unlock-p)
          #{dynamic-thread-mutex-unlock!#p}#))
  (import (only (scheme base) begin define or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-mutex-unlock.scm")))
    (else (include "dynamic-thread-mutex-unlock.scm"))))
