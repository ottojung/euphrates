
(define-library
  (euphrates labelinglogic-binding-check)
  (export labelinglogic:binding:check)
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates labelinglogic-expression-check)
          labelinglogic:expression:check))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (euphrates unique-identifier)
          unique-identifier?))
  (import
    (only (scheme base)
          =
          and
          begin
          define
          list
          list?
          member
          or
          quote
          symbol?
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-binding-check.scm")))
    (else (include "labelinglogic-binding-check.scm"))))
