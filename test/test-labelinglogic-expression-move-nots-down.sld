
(define-library
  (test-labelinglogic-expression-move-nots-down)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates
            labelinglogic-expression-move-nots-down)
          labelinglogic:expression:move-nots-down))
  (import
    (only (scheme base)
          _
          and
          begin
          define
          define-syntax
          let
          not
          or
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-labelinglogic-expression-move-nots-down.scm")))
    (else (include
            "test-labelinglogic-expression-move-nots-down.scm"))))
