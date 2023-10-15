
(define-library
  (test-string-to-radix3)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates string-to-radix3)
          string->radix3))
  (import
    (only (euphrates radix3-to-string)
          radix3->string))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-string-to-radix3.scm")))
    (else (include "test-string-to-radix3.scm"))))
