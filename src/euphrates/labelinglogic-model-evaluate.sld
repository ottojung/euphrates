
(define-library
  (euphrates labelinglogic-model-evaluate)
  (export labelinglogic:model:evaluate)
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates labelinglogic-binding-expr)
          labelinglogic:binding:expr))
  (import
    (only (euphrates labelinglogic-binding-name)
          labelinglogic:binding:name))
  (import
    (only (euphrates labelinglogic-expression-evaluate)
          labelinglogic:expression:evaluate))
  (import
    (only (euphrates labelinglogic-model-bindings)
          labelinglogic:model:bindings))
  (import
    (only (scheme base) and begin define lambda map))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-evaluate.scm")))
    (else (include "labelinglogic-model-evaluate.scm"))))
