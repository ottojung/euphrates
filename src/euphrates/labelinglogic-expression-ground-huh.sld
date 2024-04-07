
(define-library
  (euphrates labelinglogic-expression-ground-huh)
  (export labelinglogic:expression:ground?)
  (import
    (only (euphrates labelinglogic-expression-type)
          labelinglogic:expression:type))
  (import
    (only (scheme base)
          =
          begin
          define
          list
          member
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-ground-huh.scm")))
    (else (include
            "labelinglogic-expression-ground-huh.scm"))))
