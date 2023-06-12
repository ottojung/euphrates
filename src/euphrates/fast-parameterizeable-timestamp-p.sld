
(define-library
  (euphrates fast-parameterizeable-timestamp-p)
  (export fast-parameterizeable-timestamp/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/fast-parameterizeable-timestamp-p.scm")))
    (else (include "fast-parameterizeable-timestamp-p.scm"))))
