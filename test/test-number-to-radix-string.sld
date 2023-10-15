
(define-library
  (test-number-to-radix-string)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates number-to-binary-string)
          number->binary-string))
  (import
    (only (euphrates number-to-decimal-string)
          number->decimal-string))
  (import
    (only (euphrates number-to-hexadecimal-string)
          number->hexadecimal-string))
  (import
    (only (euphrates number-to-octal-string)
          number->octal-string))
  (import
    (only (euphrates number-to-radix-string)
          number->radix-string))
  (import (only (scheme base) begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-number-to-radix-string.scm")))
    (else (include "test-number-to-radix-string.scm"))))
