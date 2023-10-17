
(define-library
  (euphrates labelinglogic-expression-args)
  (export labelinglogic:expression:args)
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (scheme base)
          begin
          cdr
          cond
          define
          else
          equal?
          list
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-args.scm")))
    (else (include "labelinglogic-expression-args.scm"))))
