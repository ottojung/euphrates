
(define-library
  (euphrates tilda-a)
  (export ~a)
  (import
    (only (euphrates call-with-output-string)
          call-with-output-string))
  (import
    (only (scheme base)
          begin
          char?
          cond
          define
          else
          lambda
          number->string
          number?
          string
          string?))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/tilda-a.scm")))
    (else (include "tilda-a.scm"))))
