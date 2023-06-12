
(define-library
  (euphrates memconst)
  (export memconst)
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          if
          lambda
          let
          set!
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/memconst.scm")))
    (else (include "memconst.scm"))))
