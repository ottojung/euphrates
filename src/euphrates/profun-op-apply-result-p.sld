
(define-library
  (euphrates profun-op-apply-result-p)
  (export profun-op-apply/result/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-apply-result-p.scm")))
    (else (include "profun-op-apply-result-p.scm"))))
