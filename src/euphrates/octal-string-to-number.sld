
(define-library
  (euphrates octal-string-to-number)
  (export octal-string->number)
  (import
    (only (euphrates radix-string-to-number)
          radix-string->number))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/octal-string-to-number.scm")))
    (else (include "octal-string-to-number.scm"))))
