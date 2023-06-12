
(define-library
  (test-list-zip-with)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates list-zip-with) list-zip-with)
    (only (scheme base) begin let list quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-zip-with.scm")))
    (else (include "test-list-zip-with.scm"))))
