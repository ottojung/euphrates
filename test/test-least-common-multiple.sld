
(define-library
  (test-least-common-multiple)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates least-common-multiple)
          least-common-multiple))
  (import (only (scheme base) begin quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-least-common-multiple.scm")))
    (else (include "test-least-common-multiple.scm"))))
