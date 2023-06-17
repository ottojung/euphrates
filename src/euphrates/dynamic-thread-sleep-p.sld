
(define-library
  (euphrates dynamic-thread-sleep-p)
  (export dynamic-thread-sleep/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-sleep-p.scm")))
    (else (include "dynamic-thread-sleep-p.scm"))))
