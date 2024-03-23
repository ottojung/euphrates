
(define-library
  (euphrates labelinglogic-expression-top)
  (export labelinglogic:expression:top)
  (import
    (only (euphrates labelinglogic-expression-make)
          labelinglogic:expression:make))
  (import
    (only (scheme base) begin define or quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-top.scm")))
    (else (include "labelinglogic-expression-top.scm"))))
