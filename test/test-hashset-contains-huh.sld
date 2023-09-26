
(define-library
  (test-hashset-contains-huh)
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates hashset)
          hashset-contains?
          list->hashset))
  (import (only (scheme base) begin not quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-hashset-contains-huh.scm")))
    (else (include "test-hashset-contains-huh.scm"))))
