
(define-library
  (euphrates labelinglogic-model-alpha-rename)
  (export labelinglogic:model:alpha-rename)
  (import
    (only (euphrates labelinglogic-model-foreach-variable)
          labelinglogic:model:foreach-variable))
  (import
    (only (euphrates labelinglogic-model-rename-variables)
          labelinglogic:model:rename-variables))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import
    (only (euphrates unique-identifier-to-symbol)
          unique-identifier->symbol))
  (import
    (only (euphrates unique-identifier)
          unique-identifier?
          with-unique-identifier-context))
  (import
    (only (scheme base) begin define if lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-alpha-rename.scm")))
    (else (include "labelinglogic-model-alpha-rename.scm"))))
