
(define-library
  (euphrates dynamic-thread-wait-delay-p-default)
  (export
    dynamic-thread-wait-delay/us/p-default)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-wait-delay-p-default.scm")))
    (else (include
            "dynamic-thread-wait-delay-p-default.scm"))))
