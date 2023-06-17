
(define-library
  (euphrates run-syncproc-re)
  (export run-syncproc/re)
  (import
    (only (euphrates asyncproc) asyncproc-status))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates run-syncproc-star)
          run-syncproc*))
  (import
    (only (euphrates with-output-to-string)
          with-output-to-string))
  (import
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
