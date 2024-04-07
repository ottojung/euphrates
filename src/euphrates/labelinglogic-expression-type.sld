
(define-library
  (euphrates labelinglogic-expression-type)
  (export labelinglogic:expression:type)
  (import
    (only (euphrates unique-identifier)
          unique-identifier?))
  (import
    (only (scheme base)
          begin
          cond
          define
          else
          list-ref
          number?
          quote
          symbol?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-type.scm")))
    (else (include "labelinglogic-expression-type.scm"))))
