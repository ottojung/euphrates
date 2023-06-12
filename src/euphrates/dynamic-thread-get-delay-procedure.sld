
(define-library
  (euphrates dynamic-thread-get-delay-procedure)
  (export dynamic-thread-get-delay-procedure)
  (import
    (only (euphrates
            dynamic-thread-get-delay-procedure-p-default)
          #{dynamic-thread-get-delay-procedure#p-default}#)
    (only (euphrates dynamic-thread-get-delay-procedure-p)
          #{dynamic-thread-get-delay-procedure#p}#)
    (only (scheme base) begin define if let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-get-delay-procedure.scm")))
    (else (include
            "dynamic-thread-get-delay-procedure.scm"))))
