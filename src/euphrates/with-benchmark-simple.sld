
(define-library
  (euphrates with-benchmark-simple)
  (export
    with-benchmark/simple
    with-benchmark/timestamp)
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
  (import
    (only (euphrates list-fold-semigroup)
          list-fold/semigroup))
  (import
    (only (euphrates list-number-average)
          list-number-average))
  (import
    (only (euphrates stack)
          stack->list
          stack-make
          stack-push!))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          *
          +
          -
          /
          _
          begin
          car
          cdr
          cond
          cons
          current-error-port
          current-output-port
          define
          define-syntax
          define-values
          else
          equal?
          if
          lambda
          let
          let*
          make-parameter
          map
          newline
          null?
          parameterize
          quasiquote
          quote
          reverse
          round
          string-append
          string-map
          syntax-rules
          unquote
          values
          vector
          vector->list))
  (import
    (only (scheme file) call-with-output-file))
  (import (only (scheme r5rs) exact->inexact))
  (import
    (only (scheme time)
          current-jiffy
          jiffies-per-second))
  (import (only (scheme write) display write))
  (cond-expand
    (guile (import (only (srfi srfi-18) current-time)))
    (else (import (only (srfi 18) current-time))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/with-benchmark-simple.scm")))
    (else (include "with-benchmark-simple.scm"))))
