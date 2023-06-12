
(define-library
  (euphrates sys-thread-current-p-default)
  (export #{sys-thread-current#p-default}#)
  (import
    (only (euphrates sys-thread-obj) sys-thread-obj)
    (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/sys-thread-current-p-default.scm")))
    (else (include "sys-thread-current-p-default.scm"))))
