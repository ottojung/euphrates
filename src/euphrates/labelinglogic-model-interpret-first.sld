
(define-library
  (euphrates labelinglogic-model-interpret-first)
  (export labelinglogic:model:interpret/first)
  (import
    (only (euphrates labelinglogic-binding-expr)
          labelinglogic:binding:expr))
  (import
    (only (euphrates labelinglogic-binding-name)
          labelinglogic:binding:name))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates labelinglogic-model-bindings)
          labelinglogic:model:bindings))
  (import
    (only (euphrates labelinglogic-model-interpret)
          labelinglogic:model:interpret))
  (import (only (euphrates negate) negate))
  (import
    (only (scheme base)
          =
          append
          begin
          car
          define
          equal?
          if
          lambda
          null?
          quote))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-interpret-first.scm")))
    (else (include
            "labelinglogic-model-interpret-first.scm"))))
