
(define-library
  (euphrates labelinglogic-model-alpha-rename)
  (export labelinglogic:model:alpha-rename)
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates hashset) hashset->list hashset?))
  (import
    (only (euphrates labelinglogic-model-replace-constants)
          labelinglogic:model:replace-constants))
  (import
    (only (euphrates unique-identifier-to-symbol)
          unique-identifier->symbol))
  (import
    (only (euphrates unique-identifier)
          unique-identifier?
          with-unique-identifier-context))
  (import
    (only (scheme base)
          append
          begin
          define
          if
          lambda
          map))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-alpha-rename.scm")))
    (else (include "labelinglogic-model-alpha-rename.scm"))))
