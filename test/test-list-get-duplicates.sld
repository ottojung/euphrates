
(define-library
  (test-list-get-duplicates)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates list-get-duplicates)
          list-get-duplicates))
  (import (only (scheme base) begin even? quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-list-get-duplicates.scm")))
    (else (include "test-list-get-duplicates.scm"))))
