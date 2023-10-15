
(define-library
  (euphrates number-to-radix-string)
  (export number->radix-string)
  (import
    (only (euphrates number-to-radix3)
          number->radix3))
  (import
    (only (euphrates radix3-to-string)
          radix3->string))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/number-to-radix-string.scm")))
    (else (include "number-to-radix-string.scm"))))
