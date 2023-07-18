
(define-library
  (test-letin)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates letin) letin))
  (import
    (only (scheme base)
          +
          begin
          cond-expand
          do
          let
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-letin.scm")))
    (else (include "test-letin.scm"))))
