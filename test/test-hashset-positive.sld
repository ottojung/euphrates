
(define-library
  (test-hashset-positive)
  (import
    (only (euphrates assert) assert)
    (only (euphrates hashset)
          hashset-equal?
          make-hashset)
    (only (scheme base) begin let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-hashset-positive.scm")))
    (else (include "test-hashset-positive.scm"))))
