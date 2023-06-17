
(define-library
  (euphrates run-asyncproc)
  (export run-asyncproc)
  (import
    (only (euphrates run-asyncproc-p)
          run-asyncproc/p))
  (import (only (scheme base) apply begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/run-asyncproc.scm")))
    (else (include "run-asyncproc.scm"))))
