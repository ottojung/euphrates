
(define-library
  (euphrates with-string-as-input)
  (export with-string-as-input)
  (import
    (only (euphrates call-with-input-string)
          call-with-input-string))
  (import
    (only (scheme base)
          _
          begin
          current-input-port
          define-syntax
          lambda
          let
          parameterize
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/with-string-as-input.scm")))
    (else (include "with-string-as-input.scm"))))
