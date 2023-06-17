
(define-library
  (euphrates run-syncproc-star)
  (export run-syncproc*)
  (import
    (only (euphrates run-asyncproc) run-asyncproc))
  (import
    (only (euphrates with-singlethread-env)
          with-singlethread-env))
  (import
    (only (scheme base) apply begin cons define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/run-syncproc-star.scm")))
    (else (include "run-syncproc-star.scm"))))
