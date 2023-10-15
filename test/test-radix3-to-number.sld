
(define-library
  (test-radix3-to-number)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates radix3-to-number)
          radix3->number))
  (import
    (only (euphrates string-to-radix3)
          string->radix3))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-radix3-to-number.scm")))
    (else (include "test-radix3-to-number.scm"))))
