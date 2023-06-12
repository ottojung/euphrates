
(define-library
  (test-list-length=)
  (import
    (only (euphrates assert) assert)
    (only (euphrates list-length-eq) list-length=)
    (only (scheme base) begin let not quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-length=.scm")))
    (else (include "test-list-length=.scm"))))
