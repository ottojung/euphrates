
(define-library
  (test-labelinglogic-expression-to-dnf)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates labelinglogic-expression-sugarify)
          labelinglogic:expression:sugarify))
  (import
    (only (euphrates labelinglogic-expression-to-dnf)
          labelinglogic:expression:to-dnf))
  (import
    (only (scheme base)
          and
          begin
          define
          not
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-labelinglogic-expression-to-dnf.scm")))
    (else (include
            "test-labelinglogic-expression-to-dnf.scm"))))
