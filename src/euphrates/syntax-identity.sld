
(define-library
  (euphrates syntax-identity)
  (export syntax-identity)
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/syntax-identity.scm")))
    (else (include "syntax-identity.scm"))))
