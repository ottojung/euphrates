
(define-library
  (euphrates call-with-output-string)
  (export call-with-output-string)
  (import
    (only (scheme base)
          begin
          close-port
          define
          get-output-string
          let
          open-output-string))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/call-with-output-string.scm")))
    (else (include "call-with-output-string.scm"))))
