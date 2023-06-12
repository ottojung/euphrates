
(define-library
  (euphrates asyncproc-stdout)
  (export asyncproc-stdout)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/asyncproc-stdout.scm")))
    (else (include "asyncproc-stdout.scm"))))
