
(define-library
  (euphrates dynamic-thread-critical-make-p)
  (export dynamic-thread-critical-make/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-critical-make-p.scm")))
    (else (include "dynamic-thread-critical-make-p.scm"))))
