
(define-library
  (euphrates labelinglogic-model-check)
  (export labelinglogic:model:check)
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates hashmap)
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates hashset)
          hashset-has?
          list->hashset))
  (import
    (only (euphrates labelinglogic-binding-check)
          labelinglogic:binding:check))
  (import
    (only (euphrates labelinglogic-expression-constants)
          labelinglogic:expression:constants))
  (import (only (euphrates negate) negate))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          assoc
          begin
          car
          cons
          define
          for-each
          lambda
          let
          list
          list?
          map
          member
          null?
          procedure?
          quote
          reverse
          symbol?
          unless
          when))
  (import (only (scheme eval) environment eval))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-model-check.scm")))
    (else (include "labelinglogic-model-check.scm"))))
