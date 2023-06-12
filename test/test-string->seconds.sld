
(define-library
  (test-string->seconds)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates string-to-seconds)
          string->seconds)
    (only (scheme base) * + begin let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-string->seconds.scm")))
    (else (include "test-string->seconds.scm"))))
