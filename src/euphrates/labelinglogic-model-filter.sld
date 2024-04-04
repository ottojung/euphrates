
(define-library
  (euphrates labelinglogic-model-filter)
  (export labelinglogic:model:filter)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-filter.scm")))
    (else (include "labelinglogic-model-filter.scm"))))
