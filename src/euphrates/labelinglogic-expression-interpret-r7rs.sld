
(define-library
  (euphrates
    labelinglogic-expression-interpret-r7rs)
  (export labelinglogic:expression:interpret/r7rs)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-interpret-r7rs-code)
          labelinglogic:interpret-r7rs-code))
  (import (only (scheme base) begin car define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-interpret-r7rs.scm")))
    (else (include
            "labelinglogic-expression-interpret-r7rs.scm"))))
