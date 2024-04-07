
(define-library
  (euphrates labelinglogic-model-append)
  (export labelinglogic:model:append)
  (import (only (scheme base) append begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-append.scm")))
    (else (include "labelinglogic-model-append.scm"))))
