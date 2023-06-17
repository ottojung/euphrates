
(define-library
  (euphrates dynamic-thread-sleep)
  (export dynamic-thread-sleep)
  (import
    (only (euphrates dynamic-thread-sleep-p-default)
          #{dynamic-thread-sleep#p-default}#))
  (import
    (only (euphrates dynamic-thread-sleep-p)
          #{dynamic-thread-sleep#p}#))
  (import (only (scheme base) begin define or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-sleep.scm")))
    (else (include "dynamic-thread-sleep.scm"))))
