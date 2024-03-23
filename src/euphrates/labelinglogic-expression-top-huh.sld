(define-library
  (euphrates labelinglogic-expression-top-huh)
  (export labelinglogic:expression:top?)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-top-huh.scm")))
    (else (include "labelinglogic-expression-top-huh.scm"))))
