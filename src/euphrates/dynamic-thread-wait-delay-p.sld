
(define-library
  (euphrates dynamic-thread-wait-delay-p)
  (export #{dynamic-thread-wait-delay#us#p}#)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-wait-delay-p.scm")))
    (else (include "dynamic-thread-wait-delay-p.scm"))))
