
(define-library
  (test-list-reduce/pairwise)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates list-reduce-pairwise)
          list-reduce/pairwise))
  (import
    (only (scheme base)
          +
          =
          >
          and
          begin
          equal?
          if
          lambda
          list
          modulo
          null?
          number?
          quote
          string=?))
  (import (only (scheme char) char-alphabetic?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-list-reduce/pairwise.scm")))
    (else (include "test-list-reduce/pairwise.scm"))))
