
(define-library
  (euphrates with-benchmark-simple)
  (export with-benchmark/simple)
  (import
    (only (euphrates date-get-current-string)
          date-get-current-string))
  (import
    (only (euphrates display-alist-as-json)
          display-alist-as-json))
  (import (only (euphrates fn-cons) fn-cons))
  (import
    (only (euphrates get-euphrates-revision-date)
          get-euphrates-revision-date))
  (import
    (only (euphrates get-euphrates-revision-id)
          get-euphrates-revision-id))
  (import
    (only (euphrates get-euphrates-revision-title)
          get-euphrates-revision-title))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates list-number-average)
          list-number-average))
  (import
    (only (euphrates with-run-time-estimate)
          with-run-time-estimate))
  (import
    (only (scheme base)
          *
          /
          _
          begin
          car
          current-error-port
          current-output-port
          define
          define-syntax
          lambda
          let
          let*
          map
          newline
          parameterize
          quasiquote
          quote
          round
          string-append
          syntax-rules
          unquote
          vector
          vector->list))
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
