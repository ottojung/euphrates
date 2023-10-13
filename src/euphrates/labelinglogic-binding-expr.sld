
(define-library
  (euphrates labelinglogic-binding-expr)
  (export labelinglogic::binding:expr)
  (import
    (only (scheme base) begin define list-ref))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-binding-expr.scm")))
    (else (include "labelinglogic-binding-expr.scm"))))
