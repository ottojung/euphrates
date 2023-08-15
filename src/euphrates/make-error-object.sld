
(define-library
  (euphrates make-error-object)
  (export make-error-object)
  (import
    (only (scheme base)
          apply
          begin
          cons
          define
          error
          guard))
  (cond-expand
    (guile (import (only (srfi srfi-35) condition)))
    (else (import (only (srfi 35) condition))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/make-error-object.scm")))
    (else (include "make-error-object.scm"))))
