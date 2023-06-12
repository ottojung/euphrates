
(define-library
  (test-string-to-seconds-columned)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates string-to-seconds-columned)
          string->seconds/columned)
    (only (euphrates string-to-seconds)
          string->seconds)
    (only (scheme base) * + begin let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-string-to-seconds-columned.scm")))
    (else (include "test-string-to-seconds-columned.scm"))))
