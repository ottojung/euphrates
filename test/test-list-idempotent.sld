
(define-library
  (test-list-idempotent)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates list-idempotent)
          list-idempotent))
  (import
    (only (scheme base)
          =
          >
          begin
          define
          equal?
          if
          lambda
          list
          modulo
          or
          quote
          remainder))
  (import (only (scheme char) string-ci=?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-idempotent.scm")))
    (else (include "test-list-idempotent.scm"))))
