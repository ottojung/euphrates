
(define-library
  (euphrates fraction-to-decimal-string)
  (export fraction->decimal-string)
  (import
    (only (euphrates fraction-to-radix-string)
          fraction->radix-string))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/fraction-to-decimal-string.scm")))
    (else (include "fraction-to-decimal-string.scm"))))
