
(define-library
  (euphrates package)
  (export
    use-svars
    with-svars
    with-package
    make-package
    make-static-package)
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap)
    (only (scheme base)
          _
          assq
          begin
          cdr
          cons
          define-syntax
          if
          lambda
          let
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/package.scm")))
    (else (include "package.scm"))))
