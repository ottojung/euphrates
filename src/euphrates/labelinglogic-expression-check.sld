
(define-library
  (euphrates labelinglogic-expression-check)
  (export labelinglogic:expression:check)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates labelinglogic-expression-compile-r7rs)
          labelinglogic:expression:compile/r7rs))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import
    (only (euphrates list-length-geq-q)
          list-length=<?))
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
          cond
          define
          else
          equal?
          for-each
          list
          list?
          not
          number?
          or
          procedure?
          quote
          symbol?
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-check.scm")))
    (else (include "labelinglogic-expression-check.scm"))))
