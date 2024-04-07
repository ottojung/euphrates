
(define-library
  (euphrates labelinglogic-expression-finite-huh)
  (export labelinglogic:expression:finite?)
  (import
    (only (euphrates labelinglogic-expression-infinite-huh)
          labelinglogic:expression:infinite?))
  (import (only (scheme base) begin define not))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-finite-huh.scm")))
    (else (include
            "labelinglogic-expression-finite-huh.scm"))))
