
(define-library
  (euphrates sys-thread-current-p)
  (export sys-thread-current/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/sys-thread-current-p.scm")))
    (else (include "sys-thread-current-p.scm"))))
