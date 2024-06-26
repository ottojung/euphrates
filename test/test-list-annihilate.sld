
(define-library
  (test-list-annihilate)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates list-annihilate)
          list-annihilate))
  (import
    (only (scheme base)
          =
          and
          begin
          char=?
          cons
          define
          equal?
          even?
          lambda
          list
          or
          quote
          string=?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-annihilate.scm")))
    (else (include "test-list-annihilate.scm"))))
