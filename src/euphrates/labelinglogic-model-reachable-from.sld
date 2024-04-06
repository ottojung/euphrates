
(define-library
  (euphrates labelinglogic-model-reachable-from)
  (export labelinglogic:model:reachable-from)
  (import
    (only (euphrates hashset)
          hashset-add!
          hashset-copy))
  (import
    (only (euphrates labelinglogic-expression-constants)
          labelinglogic:expression:constants))
  (import
    (only (euphrates
            labelinglogic-model-foreach-expression)
          labelinglogic:model:foreach-expression))
  (import
    (only (scheme base) begin define for-each lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-reachable-from.scm")))
    (else (include
            "labelinglogic-model-reachable-from.scm"))))
