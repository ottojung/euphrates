
(define-library
  (euphrates
    labelinglogic-expression-check-nothrow)
  (export labelinglogic:expression:check/nothrow)
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
  (import
    (only (euphrates list-map-first) list-map-first))
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
          let
          list
          list?
          not
          number?
          or
          procedure?
          quote
          symbol?
          unless
          vector))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-check-nothrow.scm")))
    (else (include
            "labelinglogic-expression-check-nothrow.scm"))))
