(define-library
  (euphrates labelinglogic-expression-type)
  (export labelinglogic::expression:type)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-type.scm")))
    (else (include "labelinglogic-expression-type.scm"))))
