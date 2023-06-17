
(define-library
  (euphrates
    dynamic-thread-critical-make-p-default)
  (export
    dynamic-thread-critical-make/p-default)
  (import (only (scheme base) begin define lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-critical-make-p-default.scm")))
    (else (include
            "dynamic-thread-critical-make-p-default.scm"))))
