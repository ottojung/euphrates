
(define-library
  (test-hashset-positive)
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates hashset)
          hashset-equal?
          make-hashset))
  (import
    (only (scheme base) begin cond-expand let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-hashset-positive.scm")))
    (else (include "test-hashset-positive.scm"))))
