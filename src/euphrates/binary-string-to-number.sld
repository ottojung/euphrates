
(define-library
  (euphrates binary-string-to-number)
  (export binary-string->number)
  (import
    (only (euphrates radix-string-to-number)
          radix-string->number))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/binary-string-to-number.scm")))
    (else (include "binary-string-to-number.scm"))))
