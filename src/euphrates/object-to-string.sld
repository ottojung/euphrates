
(define-library
  (euphrates object-to-string)
  (export object->string)
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
          string?
          symbol->string
          symbol?))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/object-to-string.scm")))
    (else (include "object-to-string.scm"))))
