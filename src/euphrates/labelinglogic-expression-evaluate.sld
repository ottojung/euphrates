
(define-library
  (euphrates labelinglogic-expression-evaluate)
  (export labelinglogic:expression:evaluate)
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates
            labelinglogic-expression-evaluate-equal)
          labelinglogic:expression:evaluate/equal))
  (import
    (only (euphrates
            labelinglogic-expression-evaluate-r7rs)
          labelinglogic:expression:evaluate/r7rs))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates list-or-map) list-or-map))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          =
          assoc
          begin
          cond
          define
          else
          equal?
          lambda
          list
          or
          quote
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-evaluate.scm")))
    (else (include "labelinglogic-expression-evaluate.scm"))))
