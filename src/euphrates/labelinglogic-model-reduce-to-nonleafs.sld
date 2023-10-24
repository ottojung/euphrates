
(define-library
  (euphrates
    labelinglogic-model-reduce-to-nonleafs)
  (export labelinglogic:model:reduce-to-nonleafs)
  (import
    (only (euphrates labelinglogic-binding-leaf-huh)
          labelinglogic:binding:leaf?))
  (import (only (euphrates negate) negate))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-reduce-to-nonleafs.scm")))
    (else (include
            "labelinglogic-model-reduce-to-nonleafs.scm"))))
