
(define-library
  (test-seconds->time-string)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates time-to-string)
          seconds->time-string)
    (only (scheme base) * + begin let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-seconds->time-string.scm")))
    (else (include "test-seconds->time-string.scm"))))
