
(define-library
  (test-list-take-while)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates list-take-while)
          list-take-while)
    (only (scheme base) begin even? let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-take-while.scm")))
    (else (include "test-list-take-while.scm"))))
