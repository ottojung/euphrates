
(define-library
  (test-compose-under)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates compose-under) compose-under))
  (import (only (euphrates range) range))
  (import
    (only (scheme base)
          *
          +
          -
          begin
          cond-expand
          let
          list
          odd?
          or
          zero?))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-compose-under.scm")))
    (else (include "test-compose-under.scm"))))
