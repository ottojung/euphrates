
(define-library
  (euphrates labelinglogic-expression-make)
  (export labelinglogic:expression:make)
  (import (only (scheme base) begin cons define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-make.scm")))
    (else (include "labelinglogic-expression-make.scm"))))
