
(define-library
  (test-list-group-by)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates list-group-by) list-group-by))
  (import
    (only (scheme base)
          begin
          cond-expand
          even?
          lambda
          let
          modulo
          not
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-group-by.scm")))
    (else (include "test-list-group-by.scm"))))
