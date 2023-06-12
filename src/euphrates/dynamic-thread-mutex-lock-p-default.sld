
(define-library
  (euphrates dynamic-thread-mutex-lock-p-default)
  (export #{dynamic-thread-mutex-lock!#p-default}#)
  (import
    (only (scheme base) _ begin define lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-mutex-lock-p-default.scm")))
    (else (include
            "dynamic-thread-mutex-lock-p-default.scm"))))
