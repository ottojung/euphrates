
(define-library
  (test-fraction-to-binary-string)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates fraction-to-binary-string)
          fraction->binary-string))
  (import (only (scheme base) * / begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-fraction-to-binary-string.scm")))
    (else (include "test-fraction-to-binary-string.scm"))))
