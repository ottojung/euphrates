
(define-library
  (test-compose-under-par)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates compose-under-par)
          compose-under-par)
    (only (euphrates range) range)
    (only (scheme base)
          *
          +
          -
          begin
          lambda
          let
          list
          map
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-compose-under-par.scm")))
    (else (include "test-compose-under-par.scm"))))
