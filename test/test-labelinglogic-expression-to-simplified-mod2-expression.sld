
(define-library
  (test-labelinglogic-expression-to-simplified-mod2-expression)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates
            labelinglogic-expression-to-mod2-expression)
          labelinglogic:expression->mod2-expression))
  (import
    (only (euphrates
            labelinglogic-expression-to-simplified-mod2-expression)
          labelinglogic:expression->simplified-mod2-expression))
  (import
    (only (scheme base)
          *
          +
          =
          and
          begin
          define
          not
          or
          quote))
  (cond-expand
    (guile (import (only (srfi srfi-64) test-eq)))
    (else (import (only (srfi 64) test-eq))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-labelinglogic-expression-to-simplified-mod2-expression.scm")))
    (else (include
            "test-labelinglogic-expression-to-simplified-mod2-expression.scm"))))
