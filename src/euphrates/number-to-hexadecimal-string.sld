
(define-library
  (euphrates number-to-hexadecimal-string)
  (export number->hexadecimal-string)
  (import
    (only (euphrates number-to-radix-string)
          number->radix-string))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/number-to-hexadecimal-string.scm")))
    (else (include "number-to-hexadecimal-string.scm"))))
