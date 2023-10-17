
(define-library
  (test-unique-identifier)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates unique-identifier)
          make-unique-identifier
          unique-identifier->list
          with-unique-identifier-context))
  (import
    (only (scheme base) begin define let list quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-unique-identifier.scm")))
    (else (include "test-unique-identifier.scm"))))
