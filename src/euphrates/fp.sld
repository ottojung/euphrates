
(define-library
  (euphrates fp)
  (export fp)
  (import
    (only (scheme base)
          _
          apply
          begin
          define-syntax
          lambda
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "euphrates/fp.scm")))
    (else (include "fp.scm"))))
