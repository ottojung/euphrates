
(define-library
  (test-number-to-binary-string)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates number-to-binary-string)
          number->binary-string))
  (import (only (scheme base) * / begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-number-to-binary-string.scm")))
    (else (include "test-number-to-binary-string.scm"))))
