
(define-library
  (test-with-run-time-estimate)
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates with-run-time-estimate)
          with-run-time-estimate))
  (import
    (only (scheme base)
          +
          -
          <
          =
          begin
          cond
          define
          else
          inexact?
          let
          number?
          when))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-with-run-time-estimate.scm")))
    (else (include "test-with-run-time-estimate.scm"))))
