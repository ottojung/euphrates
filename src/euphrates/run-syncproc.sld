
(define-library
  (euphrates run-syncproc)
  (export run-syncproc)
  (import
    (only (euphrates asyncproc) asyncproc-status)
    (only (euphrates run-syncproc-star)
          run-syncproc*)
    (only (scheme base) apply begin cons define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/run-syncproc.scm")))
    (else (include "run-syncproc.scm"))))
