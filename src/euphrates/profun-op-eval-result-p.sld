
(define-library
  (euphrates profun-op-eval-result-p)
  (export profun-op-eval/result/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-op-eval-result-p.scm")))
    (else (include "profun-op-eval-result-p.scm"))))
