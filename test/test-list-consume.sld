
(define-library
  (test-list-consume)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates list-consume)
          list-consume))
  (import
    (only (scheme base)
          <
          =
          >
          and
          begin
          define
          equal?
          if
          lambda
          list
          modulo
          number?
          or
          quote
          remainder))
  (import (only (scheme char) string-ci=?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-consume.scm")))
    (else (include "test-list-consume.scm"))))
