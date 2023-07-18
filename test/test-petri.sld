
(define-library
  (test-petri)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates lines-to-string) lines->string))
  (import
    (only (euphrates np-thread-parameterize)
          with-np-thread-env/non-interruptible))
  (import
    (only (euphrates petri-net-parse-profun)
          petri-profun-net))
  (import
    (only (euphrates petri-net-parse)
          petri-lambda-net))
  (import
    (only (euphrates petri) petri-push petri-run))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (scheme base)
          apply
          begin
          case
          cond-expand
          define
          else
          lambda
          let
          list
          quasiquote
          quote
          unquote))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "test-petri.scm")))
    (else (include "test-petri.scm"))))
