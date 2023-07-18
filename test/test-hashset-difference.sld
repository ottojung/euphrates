
(define-library
  (test-hashset-difference)
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates hashset)
          hashset-difference
          hashset-equal?
          make-hashset))
  (import
    (only (scheme base) begin cond-expand let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-hashset-difference.scm")))
    (else (include "test-hashset-difference.scm"))))
