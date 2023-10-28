
(define-library
  (test-list-fold-right-semigroup)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates list-fold-right-semigroup)
          list-fold/right/semigroup))
  (import
    (only (scheme base)
          *
          +
          begin
          list
          quote
          string-append))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-list-fold-right-semigroup.scm")))
    (else (include "test-list-fold-right-semigroup.scm"))))
