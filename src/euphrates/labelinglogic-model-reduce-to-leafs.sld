
(define-library
  (euphrates labelinglogic-model-reduce-to-leafs)
  (export labelinglogic:model:reduce-to-leafs)
  (import
    (only (euphrates labelinglogic-binding-leaf-huh)
          labelinglogic:binding:leaf?))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-reduce-to-leafs.scm")))
    (else (include
            "labelinglogic-model-reduce-to-leafs.scm"))))
