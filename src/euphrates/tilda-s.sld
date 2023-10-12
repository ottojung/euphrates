
(define-library
  (euphrates tilda-s)
  (export ~s)
  (import
    (only (euphrates call-with-output-string)
          call-with-output-string))
  (import
    (only (scheme base)
          begin
          cond
          define
          else
          lambda
          number->string
          number?
          symbol->string
          symbol?))
  (import (only (scheme write) write))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/tilda-s.scm")))
    (else (include "tilda-s.scm"))))
