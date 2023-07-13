
(define-library
  (euphrates with-output-stringified)
  (export with-output-stringified)
  (import
    (only (scheme base)
          _
          begin
          close-port
          current-output-port
          define-syntax
          get-output-string
          let
          open-output-string
          parameterize
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/with-output-stringified.scm")))
    (else (include "with-output-stringified.scm"))))
