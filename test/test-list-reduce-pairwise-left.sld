
(define-library
  (test-list-reduce/pairwise/left)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates list-reduce-pairwise-left)
          list-reduce/pairwise/left))
  (import
    (only (scheme base)
          +
          =
          >
          _
          and
          begin
          char?
          cons
          equal?
          if
          lambda
          list
          modulo
          null?
          number?
          quote
          string=?
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-list-reduce-pairwise-left.scm")))
    (else (include "test-list-reduce-pairwise-left.scm"))))
