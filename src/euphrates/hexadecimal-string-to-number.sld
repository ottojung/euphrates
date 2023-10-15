
(define-library
  (euphrates hexadecimal-string-to-number)
  (export hexadecimal-string->number)
  (import
    (only (euphrates radix-string-to-number)
          radix-string->number))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/hexadecimal-string-to-number.scm")))
    (else (include "hexadecimal-string-to-number.scm"))))
