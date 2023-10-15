
(define-library
  (euphrates fraction-to-decimal-string)
  (export fraction->decimal-string)
  (import
    (only (euphrates fraction-to-radix3)
          fraction->radix3))
  (import
    (only (euphrates radix3-to-string)
          radix3->string))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/fraction-to-decimal-string.scm")))
    (else (include "fraction-to-decimal-string.scm"))))
