
(define-library
  (euphrates with-output-to-string)
  (export with-output-to-string)
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
               "euphrates/with-output-to-string.scm")))
    (else (include "with-output-to-string.scm"))))
