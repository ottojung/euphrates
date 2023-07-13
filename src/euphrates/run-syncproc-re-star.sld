
(define-library
  (euphrates run-syncproc-re-star)
  (export run-syncproc/re*)
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
          apply
          begin
          cons
          define
          set!
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/run-syncproc-re-star.scm")))
    (else (include "run-syncproc-re-star.scm"))))
