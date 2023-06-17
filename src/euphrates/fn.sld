
(define-library
  (euphrates fn)
  (export fn)
  (import
    (only (euphrates syntax-identity)
          syntax-identity))
  (import (only (euphrates syntax-map) syntax-map))
  (import
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
