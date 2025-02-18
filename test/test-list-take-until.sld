
(define-library
  (test-list-take-until)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates list-take-until)
          list-take-until))
  (import
    (only (scheme base) begin even? let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-take-until.scm")))
    (else (include "test-list-take-until.scm"))))
