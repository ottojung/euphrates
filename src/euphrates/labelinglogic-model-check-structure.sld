
(define-library
  (euphrates labelinglogic-model-check-structure)
  (export labelinglogic:model:check-structure)
  (import
    (only (euphrates labelinglogic-binding-check)
          labelinglogic:binding:check))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import (only (euphrates negate) negate))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (euphrates unique-identifier)
          unique-identifier?))
  (import
    (only (scheme base)
          begin
          car
          cdr
          define
          for-each
          let
          list
          list?
          map
          null?
          or
          pair?
          quote
          symbol?
          unless))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter first)))
    (else (import (only (srfi 1) filter first))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-check-structure.scm")))
    (else (include
            "labelinglogic-model-check-structure.scm"))))
