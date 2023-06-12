
(define-library
  (euphrates call-with-input-string)
  (export call-with-input-string)
  (import
    (only (scheme base)
          _
          apply
          begin
          call-with-values
          close-port
          define
          lambda
          open-input-string
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/call-with-input-string.scm")))
    (else (include "call-with-input-string.scm"))))
