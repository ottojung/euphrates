
(define-library
  (euphrates asyncproc-stderr)
  (export asyncproc-stderr)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/asyncproc-stderr.scm")))
    (else (include "asyncproc-stderr.scm"))))
