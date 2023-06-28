
(define-library
  (test-string-to-seconds-columned)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates string-to-seconds-columned)
          string->seconds/columned))
  (import (only (scheme base) * + begin))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-string-to-seconds-columned.scm")))
    (else (include "test-string-to-seconds-columned.scm"))))
