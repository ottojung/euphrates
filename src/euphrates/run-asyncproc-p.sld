
(define-library
  (euphrates run-asyncproc-p)
  (export run-asyncproc/p)
  (import
    (only (euphrates run-asyncproc-p-default)
          run-asyncproc/p-default)
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/run-asyncproc-p.scm")))
    (else (include "run-asyncproc-p.scm"))))
