
(define-library
  (test-list-group-by)
  (import
    (only (euphrates assert-equal-hs) assert=HS)
    (only (euphrates list-group-by) list-group-by)
    (only (scheme base)
          begin
          even?
          lambda
          let
          modulo
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-list-group-by.scm")))
    (else (include "test-list-group-by.scm"))))
