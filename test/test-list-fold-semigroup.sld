
(define-library
  (test-list-fold-semigroup)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates list-fold-semigroup)
          list-fold/semigroup))
  (import
    (only (scheme base)
          *
          +
          begin
          quote
          string-append))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-list-fold-semigroup.scm")))
    (else (include "test-list-fold-semigroup.scm"))))
