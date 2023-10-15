
(define-library
  (test-fraction-to-decimal-string)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates fraction-to-decimal-string)
          fraction->decimal-string
          fraction->decimal-string/tuples))
  (import (only (scheme base) / begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-fraction-to-decimal-string.scm")))
    (else (include "test-fraction-to-decimal-string.scm"))))
