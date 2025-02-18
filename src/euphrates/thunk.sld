
(define-library
  (euphrates thunk)
  (export thunk)
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          lambda
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "euphrates/thunk.scm")))
    (else (include "thunk.scm"))))
