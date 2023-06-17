
(define-library
  (euphrates dynamic-thread-enable-cancel-p)
  (export dynamic-thread-enable-cancel/p)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-enable-cancel-p.scm")))
    (else (include "dynamic-thread-enable-cancel-p.scm"))))
