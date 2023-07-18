
(define-library
  (test-hashset-negative)
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates hashset)
          hashset-equal?
          make-hashset))
  (import (only (euphrates negate) negate))
  (import
    (only (scheme base) begin cond-expand let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-hashset-negative.scm")))
    (else (include "test-hashset-negative.scm"))))
