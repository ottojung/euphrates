
(define-library
  (euphrates dynamic-thread-cancel)
  (export dynamic-thread-cancel)
  (import
    (only (euphrates dynamic-thread-cancel-p)
          dynamic-thread-cancel/p))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base) begin define or quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-cancel.scm")))
    (else (include "dynamic-thread-cancel.scm"))))
