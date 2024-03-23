(define-library
  (euphrates labelinglogic-expression-infinite-huh)
  (export labelinglogic:expression:infinite?)
  (import
    (only (scheme base) begin define make-parameter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-infinite-huh.scm")))
    (else (include
            "labelinglogic-expression-infinite-huh.scm"))))
