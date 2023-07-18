
(define-library
  (test-run-syncproc)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates asyncproc-input-text-p)
          asyncproc-input-text/p))
  (import
    (only (euphrates asyncproc) asyncproc-status))
  (import
    (only (euphrates run-syncproc-star)
          run-syncproc*))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (scheme base)
          begin
          cond-expand
          define
          let
          parameterize))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-run-syncproc.scm")))
    (else (include "test-run-syncproc.scm"))))
