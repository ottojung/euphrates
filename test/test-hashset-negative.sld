
(define-library
  (test-hashset-negative)
  (import
    (only (euphrates assert) assert)
    (only (euphrates hashset)
          hashset-equal?
          make-hashset)
    (only (euphrates negate) negate)
    (only (scheme base) begin let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-hashset-negative.scm")))
    (else (include "test-hashset-negative.scm"))))
