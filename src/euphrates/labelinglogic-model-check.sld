
(define-library
  (euphrates labelinglogic-model-check)
  (export labelinglogic::model:check)
  (import (only (euphrates comp) comp))
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates hashmap)
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates hashset)
          hashset->list
          hashset-difference
          hashset-has?
          hashset-null?
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
  (import
    (only (euphrates make-unique) make-unique))
  (import (only (euphrates negate) negate))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          assq
          begin
          car
          define
          equal?
          for-each
          lambda
          let
          list
          list?
          map
          not
          null?
          or
          procedure?
          quote
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
