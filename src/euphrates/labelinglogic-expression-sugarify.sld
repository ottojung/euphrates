
(define-library
  (euphrates labelinglogic-expression-sugarify)
  (export labelinglogic:expression:sugarify)
  (import
    (only (euphrates labelinglogic-expression-sugarify-or)
          labelinglogic:expression:sugarify/or))
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (scheme base)
          begin
          cond
          define
          else
          equal?
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-sugarify.scm")))
    (else (include "labelinglogic-expression-sugarify.scm"))))
