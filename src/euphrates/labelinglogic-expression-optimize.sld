
(define-library
  (euphrates labelinglogic-expression-optimize)
  (export labelinglogic:expression:optimize)
  (import
    (only (euphrates labelinglogic-expression-args)
          labelinglogic:expression:args))
  (import
    (only (euphrates
            labelinglogic-expression-optimize-r7rs)
          labelinglogic:expression:optimize/r7rs))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (euphrates list-deduplicate)
          list-deduplicate))
  (import
    (only (euphrates list-singleton-q)
          list-singleton?))
  (import
    (only (scheme base)
          =
          begin
          car
          cond
          cons
          define
          else
          equal?
          if
          length
          let
          map
          or
          quote))
  (cond-expand
    (guile (import (only (srfi srfi-31) rec)))
    (else (import (only (srfi 31) rec))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-optimize.scm")))
    (else (include "labelinglogic-expression-optimize.scm"))))
