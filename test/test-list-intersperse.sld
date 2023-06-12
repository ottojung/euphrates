
(define-library
  (test-list-intersperse)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates list-intersperse)
          list-intersperse)
    (only (euphrates range) range)
    (only (scheme base) begin length let list quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-intersperse.scm")))
    (else (include "test-list-intersperse.scm"))))
