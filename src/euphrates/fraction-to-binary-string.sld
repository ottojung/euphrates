
(define-library
  (euphrates fraction-to-binary-string)
  (export fraction->binary-string)
  (import
    (only (euphrates fraction-to-radix-string)
          fraction->radix-string))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/fraction-to-binary-string.scm")))
    (else (include "fraction-to-binary-string.scm"))))
