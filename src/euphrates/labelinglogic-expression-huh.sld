(define-library
  (euphrates labelinglogic-expression-huh)
  (export labelinglogic::expression?)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-huh.scm")))
    (else (include "labelinglogic-expression-huh.scm"))))
