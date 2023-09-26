
(define-library
  (test-hashset-equal-huh)
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates hashset)
          hashset-equal?
          list->hashset))
  (import (only (scheme base) begin not quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-hashset-equal-huh.scm")))
    (else (include "test-hashset-equal-huh.scm"))))
