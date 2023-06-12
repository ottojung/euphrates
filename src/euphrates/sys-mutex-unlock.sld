
(define-library
  (euphrates sys-mutex-unlock)
  (export sys-mutex-unlock!)
  (import
    (only (scheme base) begin define)
    (only (srfi srfi-18) mutex-unlock!))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/sys-mutex-unlock.scm")))
    (else (include "sys-mutex-unlock.scm"))))
