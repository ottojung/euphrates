
(define-library
  (test-list-take-while)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates list-take-while)
          list-take-while))
  (import
    (only (scheme base)
          begin
          cond-expand
          even?
          let
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-take-while.scm")))
    (else (include "test-list-take-while.scm"))))
