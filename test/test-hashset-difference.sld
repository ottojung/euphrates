
(define-library
  (test-hashset-difference)
  (import
    (only (euphrates assert) assert)
    (only (euphrates hashset)
          hashset-difference
          hashset-equal?
          make-hashset)
    (only (scheme base) begin let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-hashset-difference.scm")))
    (else (include "test-hashset-difference.scm"))))
