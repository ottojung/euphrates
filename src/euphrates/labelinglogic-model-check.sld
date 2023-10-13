
(define-library
  (euphrates labelinglogic-model-check)
  (export labelinglogic::model:check)
  (import (only (euphrates assoc-or) assoc-or))
  (import (only (euphrates debug) debug))
  (import (only (euphrates debugs) debugs))
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates hashmap)
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates hashset)
          hashset-add!
          hashset-clear!
          hashset-has?
          list->hashset
          make-hashset))
  (import
    (only (euphrates labelinglogic-expression-check)
          labelinglogic::expression::check))
  (import
    (only (euphrates labelinglogic-expression-constants)
          labelinglogic::expression:constants))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import (only (euphrates negate) negate))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          begin
          car
          define
          for-each
          lambda
          let
          list
          list?
          map
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
