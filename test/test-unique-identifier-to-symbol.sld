
(define-library
  (test-unique-identifier-to-symbol)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates unique-identifier-to-symbol)
          unique-identifier->symbol))
  (import
    (only (euphrates unique-identifier)
          make-unique-identifier
          with-unique-identifier-context))
  (import
    (only (scheme base) begin define let quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-unique-identifier-to-symbol.scm")))
    (else (include "test-unique-identifier-to-symbol.scm"))))
