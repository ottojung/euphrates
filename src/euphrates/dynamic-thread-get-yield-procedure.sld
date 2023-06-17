
(define-library
  (euphrates dynamic-thread-get-yield-procedure)
  (export dynamic-thread-get-yield-procedure)
  (import
    (only (euphrates dynamic-thread-yield-p)
          dynamic-thread-yield/p))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-get-yield-procedure.scm")))
    (else (include
            "dynamic-thread-get-yield-procedure.scm"))))
