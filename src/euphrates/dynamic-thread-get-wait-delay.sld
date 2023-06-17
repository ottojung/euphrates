
(define-library
  (euphrates dynamic-thread-get-wait-delay)
  (export dynamic-thread-get-wait-delay)
  (import
    (only (euphrates dynamic-thread-wait-delay-p-default)
          dynamic-thread-wait-delay/us/p-default))
  (import
    (only (euphrates dynamic-thread-wait-delay-p)
          dynamic-thread-wait-delay/us/p))
  (import (only (scheme base) begin define or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-get-wait-delay.scm")))
    (else (include "dynamic-thread-get-wait-delay.scm"))))
