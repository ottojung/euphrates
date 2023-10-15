
(define-library
  (euphrates radix-string-to-number)
  (export radix-string->number)
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
             (include-from-path
               "euphrates/radix-string-to-number.scm")))
    (else (include "radix-string-to-number.scm"))))
