
(define-library
  (euphrates
    labelinglogic-expression-reduce-to-names-unsafe)
  (export
    labelinglogic:expression:reduce-to-names/unsafe)
  (import (only (euphrates hashset) hashset-has?))
  (import
    (only (euphrates labelinglogic-binding-name)
          labelinglogic:binding:name))
  (import
    (only (euphrates labelinglogic-model-filter)
          labelinglogic:model:filter))
  (import (only (scheme base) begin define lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-reduce-to-names-unsafe.scm")))
    (else (include
            "labelinglogic-expression-reduce-to-names-unsafe.scm"))))
