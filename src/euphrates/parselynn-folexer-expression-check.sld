
(define-library
  (euphrates parselynn-folexer-expression-check)
  (export parselynn:folexer:expression:check)
  (import
    (only (euphrates labelinglogic-expression-huh)
          labelinglogic:expression?))
  (import
    (only (euphrates list-singleton-q)
          list-singleton?))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          and
          begin
          car
          cdr
          char?
          cond
          define
          else
          for-each
          length
          let
          list
          list?
          member
          not
          or
          pair?
          quote
          string?
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-folexer-expression-check.scm")))
    (else (include
            "parselynn-folexer-expression-check.scm"))))
