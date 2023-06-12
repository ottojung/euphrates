
(define-library
  (euphrates sys-mutex-make)
  (export sys-mutex-make)
  (import
    (only (scheme base) begin define)
    (only (srfi srfi-18) make-mutex))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/sys-mutex-make.scm")))
    (else (include "sys-mutex-make.scm"))))
