
(define-library
  (euphrates decimal-string-to-number)
  (export decimal-string->number)
  (import
    (only (euphrates radix-string-to-number)
          radix-string->number))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/decimal-string-to-number.scm")))
    (else (include "decimal-string-to-number.scm"))))
