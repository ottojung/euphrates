
(define-library
  (euphrates
    labelinglogic-expression-combine-recursively)
  (export
    labelinglogic:expression:combine-recursively)
  (import
    (only (euphrates
            labelinglogic-expression-combine-recursively-or)
          labelinglogic:expression:combine-recursively/or))
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
               "euphrates/labelinglogic-expression-combine-recursively.scm")))
    (else (include
            "labelinglogic-expression-combine-recursively.scm"))))
