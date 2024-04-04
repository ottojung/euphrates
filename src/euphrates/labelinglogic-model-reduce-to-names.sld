
(define-library
  (euphrates labelinglogic-model-reduce-to-names)
  (export labelinglogic:model:reduce-to-names)
  (import (only (euphrates hashset) hashset-has?))
  (import
    (only (euphrates labelinglogic-binding-name)
          labelinglogic:binding:name))
  (import (only (scheme base) begin define lambda))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-reduce-to-names.scm")))
    (else (include
            "labelinglogic-model-reduce-to-names.scm"))))
