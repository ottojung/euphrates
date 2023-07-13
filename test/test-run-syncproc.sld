
(define-library
  (test-run-syncproc)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates asyncproc-input-text-p)
          asyncproc-input-text/p)
    (only (euphrates asyncproc) asyncproc-status)
    (only (euphrates run-syncproc-star)
          run-syncproc*)
    (only (euphrates with-output-stringified)
          with-output-stringified)
    (only (scheme base)
          _
          begin
          define
          lambda
          let
          parameterize))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-run-syncproc.scm")))
    (else (include "test-run-syncproc.scm"))))
