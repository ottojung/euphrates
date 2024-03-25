
(define-library
  (euphrates labelinglogic-expression-check)
  (export labelinglogic:expression:check)
  (import
    (only (euphrates
            labelinglogic-expression-check-nothrow)
          labelinglogic:expression:check/nothrow))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          begin
          define
          error
          quote
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-check.scm")))
    (else (include "labelinglogic-expression-check.scm"))))
