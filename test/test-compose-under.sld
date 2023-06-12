
(define-library
  (test-compose-under)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates compose-under) compose-under)
    (only (euphrates range) range)
    (only (scheme base)
          *
          +
          -
          begin
          let
          list
          odd?
          or
          zero?)
    (only (srfi srfi-1) filter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-compose-under.scm")))
    (else (include "test-compose-under.scm"))))
