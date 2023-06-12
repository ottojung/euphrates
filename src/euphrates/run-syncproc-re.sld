
(define-library
  (euphrates run-syncproc-re)
  (export run-syncproc/re)
  (import
    (only (euphrates asyncproc) asyncproc-status)
    (only (euphrates raisu) raisu)
    (only (euphrates run-syncproc-star)
          run-syncproc*)
    (only (euphrates with-output-to-string)
          with-output-to-string)
    (only (scheme base)
          =
          apply
          begin
          cons
          define
          quote
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/run-syncproc-re.scm")))
    (else (include "run-syncproc-re.scm"))))
