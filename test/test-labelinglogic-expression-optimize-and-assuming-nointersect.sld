
(define-library
  (test-labelinglogic-expression-optimize-and-assuming-nointersect)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates
            labelinglogic-expression-optimize-and-assuming-nointersect)
          labelinglogic:expression:optimize/and-assuming-nointersect))
  (import
    (only (scheme base)
          *
          +
          =
          and
          begin
          lambda
          not
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-labelinglogic-expression-optimize-and-assuming-nointersect.scm")))
    (else (include
            "test-labelinglogic-expression-optimize-and-assuming-nointersect.scm"))))
