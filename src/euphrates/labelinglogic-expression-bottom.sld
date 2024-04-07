
(define-library
  (euphrates labelinglogic-expression-bottom)
  (export labelinglogic:expression:bottom)
  (import
    (only (euphrates labelinglogic-expression-make)
          labelinglogic:expression:make))
  (import
    (only (scheme base) begin define or quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-bottom.scm")))
    (else (include "labelinglogic-expression-bottom.scm"))))
