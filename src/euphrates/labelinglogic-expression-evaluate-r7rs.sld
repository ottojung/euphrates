
(define-library
  (euphrates
    labelinglogic-expression-evaluate-r7rs)
  (export labelinglogic:expression:evaluate/r7rs)
  (import
    (only (euphrates labelinglogic-expression-compile-r7rs)
          labelinglogic:expression:compile/r7rs))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-evaluate-r7rs.scm")))
    (else (include
            "labelinglogic-expression-evaluate-r7rs.scm"))))
