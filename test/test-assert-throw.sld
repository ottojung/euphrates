
(define-library
  (test-assert-throw)
  (import
    (only (euphrates assert-throw) assert-throw))
  (import (only (euphrates raisu) raisu))
  (import (only (scheme base) + begin quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-assert-throw.scm")))
    (else (include "test-assert-throw.scm"))))
