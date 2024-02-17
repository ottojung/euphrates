
(define-library
  (test-list-annihilate)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates comp) comp))
  (import
    (only (euphrates list-annihilate)
          list-annihilate))
  (import
    (only (scheme base)
          -
          <
          =
          >
          abs
          and
          begin
          cons
          define
          equal?
          even?
          lambda
          list
          modulo
          number?
          or
          quote
          string=?))
  (import (only (scheme process-context) exit))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-annihilate.scm")))
    (else (include "test-list-annihilate.scm"))))
