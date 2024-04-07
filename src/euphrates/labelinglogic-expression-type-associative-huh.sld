
(define-library
  (euphrates
    labelinglogic-expression-type-associative-huh)
  (export
    labelinglogic:expression:type:associative?)
  (import
    (only (scheme base)
          and
          begin
          define
          list
          member
          not
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/labelinglogic-expression-type-associative-huh.scm")))
    (else (include
            "labelinglogic-expression-type-associative-huh.scm"))))
