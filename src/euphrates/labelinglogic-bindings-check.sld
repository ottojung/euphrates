
(define-library
  (euphrates labelinglogic-bindings-check)
  (export labelinglogic::bindings:check)
  (import
    (only (euphrates define-tuple) define-tuple))
  (import (only (euphrates hashset) hashset-has?))
  (import
    (only (euphrates labelinglogic-expression-check)
          labelinglogic::expression::check))
  (import
    (only (euphrates labelinglogic-expression-constants)
          labelinglogic::expression:constants))
  (import
    (only (euphrates list-and-map) list-and-map))
  (import
    (only (euphrates list-get-duplicates)
          list-get-duplicates))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import (only (euphrates negate) negate))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          begin
          car
          define
          for-each
          lambda
          list
          list?
          map
          null?
          pair?
          quote
          symbol?
          unless
          when))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-bindings-check.scm")))
    (else (include "labelinglogic-bindings-check.scm"))))
