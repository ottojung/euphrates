
(define-library
  (euphrates convert-number-base)
  (export
    convert-number-base
    convert-number-base/generic
    convert-number-base:default-max-base)
  (import
    (only (euphrates number-to-radix3)
          number->radix3))
  (import
    (only (euphrates radix3-change-base)
          radix3:change-base))
  (import
    (only (euphrates radix3-to-string)
          radix3->string))
  (import
    (only (euphrates string-to-radix3)
          string->radix3))
  (import (only (scheme base) begin define))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/convert-number-base.scm")))
    (else (include "convert-number-base.scm"))))
