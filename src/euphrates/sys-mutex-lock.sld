
(define-library
  (euphrates sys-mutex-lock)
  (export sys-mutex-lock!)
  (import
    (only (scheme base) begin define)
    (only (srfi srfi-18) mutex-lock!))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/sys-mutex-lock.scm")))
    (else (include "sys-mutex-lock.scm"))))
