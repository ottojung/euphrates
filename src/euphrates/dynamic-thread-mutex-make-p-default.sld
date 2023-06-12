
(define-library
  (euphrates dynamic-thread-mutex-make-p-default)
  (export #{dynamic-thread-mutex-make#p-default}#)
  (import
    (only (scheme base) _ begin define lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-mutex-make-p-default.scm")))
    (else (include
            "dynamic-thread-mutex-make-p-default.scm"))))
