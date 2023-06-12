
(define-library
  (euphrates dynamic-thread-disable-cancel-p)
  (export #{dynamic-thread-disable-cancel#p}#)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/dynamic-thread-disable-cancel-p.scm")))
    (else (include "dynamic-thread-disable-cancel-p.scm"))))
