
(define-library
  (test-jwsxcu)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates jwsxce)
          jwsxcu))
  (import
    (only (scheme base)
          *
          -
          <
          =
          >
          abs
          and
          begin
          car
          cdr
          char=?
          cons
          eq?
          equal?
          lambda
          list
          modulo
          or
          quote
          remainder
          string-length
          string=?))
  (import (only (scheme char) string-ci=?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-jwsxce.scm")))
    (else (include "test-jwsxce.scm"))))
