
(define-library
  (euphrates labelinglogic-expression-huh)
  (export labelinglogic:expression?)
  (import
    (only (euphrates
            labelinglogic-expression-check-nothrow)
          labelinglogic:expression:check/nothrow))
  (import (only (scheme base) begin define not))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-huh.scm")))
    (else (include "labelinglogic-expression-huh.scm"))))
