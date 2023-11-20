
(define-library
  (test-labelinglogic-expression-sugarify)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates labelinglogic-expression-sugarify)
          labelinglogic:expression:sugarify))
  (import
    (only (scheme base) and begin let or quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-labelinglogic-expression-sugarify.scm")))
    (else (include
            "test-labelinglogic-expression-sugarify.scm"))))
