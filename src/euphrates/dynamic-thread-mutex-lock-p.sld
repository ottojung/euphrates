
(define-library
  (euphrates dynamic-thread-mutex-lock-p)
  (export #{dynamic-thread-mutex-lock!#p}#)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-mutex-lock-p.scm")))
    (else (include "dynamic-thread-mutex-lock-p.scm"))))
