
(define-library
  (euphrates dynamic-thread-mutex-unlock-p-default)
  (export
    #{dynamic-thread-mutex-unlock!#p-default}#)
  (import
    (only (scheme base) _ begin define lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-mutex-unlock-p-default.scm")))
    (else (include
            "dynamic-thread-mutex-unlock-p-default.scm"))))
