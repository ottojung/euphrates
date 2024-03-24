
(define-library
  (test-labelinglogic-expression-to-dnf)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates
            labelinglogic-expression-optimize-assuming-nointersect-dnf)
          labelinglogic:expression:optimize/assuming-nointersect-dnf))
  (import
    (only (euphrates labelinglogic-expression-sugarify)
          labelinglogic:expression:sugarify))
  (import
    (only (euphrates labelinglogic-expression-to-dnf)
          labelinglogic:expression:to-dnf))
  (import
    (only (scheme base)
          =
          _
          and
          begin
          define-syntax
          not
          or
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-labelinglogic-expression-to-dnf.scm")))
    (else (include
            "test-labelinglogic-expression-to-dnf.scm"))))
