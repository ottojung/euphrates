
(define-library
  (euphrates with-benchmark-simple)
  (export with-benchmark/simple)
  (import
    (only (euphrates define-tuple) define-tuple))
  (import
    (only (euphrates list-mark-ends) list-mark-ends))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (euphrates with-run-time-estimate)
          with-run-time-estimate))
  (import
    (only (scheme base)
          *
          /
          _
          begin
          cadr
          car
          current-error-port
          current-output-port
          define
          define-syntax
          for-each
          lambda
          let
          let*
          newline
          parameterize
          quote
          round
          string-append
          syntax-rules
          unless))
  (import
    (only (scheme file) call-with-output-file))
  (import (only (scheme r5rs) exact->inexact))
  (import (only (scheme write) display write))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/with-benchmark-simple.scm")))
    (else (include "with-benchmark-simple.scm"))))
