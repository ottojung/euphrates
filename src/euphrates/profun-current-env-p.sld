
(define-library
  (euphrates profun-current-env-p)
  (export profun-current-env/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-current-env-p.scm")))
    (else (include "profun-current-env-p.scm"))))
