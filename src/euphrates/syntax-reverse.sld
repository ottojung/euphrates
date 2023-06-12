
(define-library
  (euphrates syntax-reverse)
  (export syntax-reverse)
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
               "euphrates/syntax-reverse.scm")))
    (else (include "syntax-reverse.scm"))))
