
(define-library
  (test-list-combinations)
  (import
    (only (euphrates assert-equal-hs) assert=HS))
  (import
    (only (euphrates list-combinations)
          list-combinations))
  (import
    (only (scheme base) begin cond-expand list quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-combinations.scm")))
    (else (include "test-list-combinations.scm"))))
