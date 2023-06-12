
(define-library
  (euphrates dynamic-thread-mutex-unlock-p)
  (export #{dynamic-thread-mutex-unlock!#p}#)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-mutex-unlock-p.scm")))
    (else (include "dynamic-thread-mutex-unlock-p.scm"))))
