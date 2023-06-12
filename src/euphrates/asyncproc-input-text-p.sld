
(define-library
  (euphrates asyncproc-input-text-p)
  (export asyncproc-input-text/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/asyncproc-input-text-p.scm")))
    (else (include "asyncproc-input-text-p.scm"))))
