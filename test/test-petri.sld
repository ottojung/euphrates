
(define-library
  (test-petri)
  (import
    (only (euphrates assert-equal) assert=)
    (only (euphrates lines-to-string) lines->string)
    (only (euphrates np-thread-parameterize)
          with-np-thread-env/non-interruptible)
    (only (euphrates petri-net-parse-profun)
          petri-profun-net)
    (only (euphrates petri-net-parse)
          petri-lambda-net)
    (only (euphrates petri) petri-push petri-run)
    (only (euphrates with-output-stringified)
          with-output-stringified)
    (only (scheme base)
          _
          apply
          begin
          case
          define
          else
          lambda
          let
          list
          quasiquote
          quote
          unquote)
    (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-petri.scm")))
    (else (include "test-petri.scm"))))
