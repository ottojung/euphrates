
(define-library
  (test-radix-string-to-number)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates binary-string-to-number)
          binary-string->number))
  (import
    (only (euphrates decimal-string-to-number)
          decimal-string->number))
  (import
    (only (euphrates hexadecimal-string-to-number)
          hexadecimal-string->number))
  (import
    (only (euphrates octal-string-to-number)
          octal-string->number))
  (import
    (only (euphrates radix-string-to-number)
          radix-string->number))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-radix-string-to-number.scm")))
    (else (include "test-radix-string-to-number.scm"))))
