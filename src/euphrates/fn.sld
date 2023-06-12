
(define-library
  (euphrates fn)
  (export fn)
  (import
    (only (euphrates syntax-identity)
          syntax-identity)
    (only (euphrates syntax-map) syntax-map)
    (only (scheme base)
          _
          begin
          define-syntax
          lambda
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "euphrates/fn.scm")))
    (else (include "fn.scm"))))
