
(define-library
  (euphrates labelinglogic-expression-args)
  (export labelinglogic:expression:args)
  (import
    (only (scheme base)
          begin
          cdr
          cond
          define
          else
          quote
          symbol?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-args.scm")))
    (else (include "labelinglogic-expression-args.scm"))))
