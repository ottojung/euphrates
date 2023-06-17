
(define-library
  (euphrates dynamic-thread-get-delay-procedure-p)
  (export dynamic-thread-get-delay-procedure/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-get-delay-procedure-p.scm")))
    (else (include
            "dynamic-thread-get-delay-procedure-p.scm"))))
