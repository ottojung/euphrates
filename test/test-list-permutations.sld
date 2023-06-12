
(define-library
  (test-list-permutations)
  (import
    (only (euphrates assert-equal-hs) assert=HS)
    (only (euphrates list-permutations)
          list-permutations)
    (only (scheme base) begin let list quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-permutations.scm")))
    (else (include "test-list-permutations.scm"))))
