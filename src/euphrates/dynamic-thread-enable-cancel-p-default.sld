
(define-library
  (euphrates
    dynamic-thread-enable-cancel-p-default)
  (export
    #{dynamic-thread-enable-cancel#p-default}#)
  (import
    (only (scheme base) _ begin define lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-enable-cancel-p-default.scm")))
    (else (include
            "dynamic-thread-enable-cancel-p-default.scm"))))
