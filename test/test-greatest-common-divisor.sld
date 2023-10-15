
(define-library
  (test-greatest-common-divisor)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates greatest-common-divisor)
          greatest-common-divisor))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-greatest-common-divisor.scm")))
    (else (include "test-greatest-common-divisor.scm"))))
