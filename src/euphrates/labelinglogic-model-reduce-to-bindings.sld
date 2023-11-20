
(define-library
  (euphrates
    labelinglogic-model-reduce-to-bindings)
  (export labelinglogic:model:reduce-to-bindings)
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates hashset)
          hashset-has?
          list->hashset))
  (import
    (only (euphrates labelinglogic-binding-name)
          labelinglogic:binding:name))
  (import
    (only (scheme base) begin define lambda map))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-reduce-to-bindings.scm")))
    (else (include
            "labelinglogic-model-reduce-to-bindings.scm"))))
