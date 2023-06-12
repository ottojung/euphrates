
(define-library
  (euphrates dynamic-thread-yield-p)
  (export #{dynamic-thread-yield#p}#)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-yield-p.scm")))
    (else (include "dynamic-thread-yield-p.scm"))))
