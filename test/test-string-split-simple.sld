
(define-library
  (test-string-split-simple)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates string-split-simple)
          string-split/simple)
    (only (scheme base) begin let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-string-split-simple.scm")))
    (else (include "test-string-split-simple.scm"))))
