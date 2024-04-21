
(define-library
  (euphrates parselynn-folexer-expression-head-huh)
  (export parselynn:folexer:expression:head?)
  (import
    (only (scheme base)
          and
          begin
          car
          char?
          cond
          define
          else
          let
          list
          list?
          member
          not
          or
          pair?
          quote
          string?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-folexer-expression-head-huh.scm")))
    (else (include
            "parselynn-folexer-expression-head-huh.scm"))))
