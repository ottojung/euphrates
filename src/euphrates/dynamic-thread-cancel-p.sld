
(define-library
  (euphrates dynamic-thread-cancel-p)
  (export #{dynamic-thread-cancel#p}#)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-cancel-p.scm")))
    (else (include "dynamic-thread-cancel-p.scm"))))
