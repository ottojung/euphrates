
(define-library
  (euphrates dynamic-thread-sleep-p-default)
  (export #{dynamic-thread-sleep#p-default}#)
  (import (only (euphrates sys-usleep) sys-usleep))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-sleep-p-default.scm")))
    (else (include "dynamic-thread-sleep-p-default.scm"))))
