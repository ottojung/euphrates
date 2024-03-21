
(define-library
  (euphrates labelinglogic-model-assoc-or)
  (export labelinglogic:model:assoc-or)
  (import (only (euphrates assoc-or) assoc-or))
  (import
    (only (scheme base)
          _
          begin
          car
          define-syntax
          let
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-assoc-or.scm")))
    (else (include "labelinglogic-model-assoc-or.scm"))))
