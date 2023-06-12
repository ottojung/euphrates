
(define-library
  (euphrates syntax-append)
  (export syntax-append)
  (import
    (only (euphrates syntax-reverse) syntax-reverse)
    (only (scheme base)
          _
          begin
          define-syntax
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/syntax-append.scm")))
    (else (include "syntax-append.scm"))))
