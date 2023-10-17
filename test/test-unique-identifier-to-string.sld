
(define-library
  (test-unique-identifier-to-string)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates unique-identifier)
          make-unique-identifier
          unique-identifier->string
          with-unique-identifier-context))
  (import
    (only (scheme base) begin define let list quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-unique-identifier-to-string.scm")))
    (else (include "test-unique-identifier-to-string.scm"))))
