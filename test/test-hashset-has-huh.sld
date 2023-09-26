
(define-library
  (test-hashset-has-huh)
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates hashset)
          hashset-has?
          list->hashset))
  (import (only (scheme base) begin not quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-hashset-has-huh.scm")))
    (else (include "test-hashset-has-huh.scm"))))
