
(define-library
  (test-string-to-numstring)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates string-to-numstring)
          string->numstring))
  (import
    (only (scheme base) begin cond-expand let))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-string-to-numstring.scm")))
    (else (include "test-string-to-numstring.scm"))))
