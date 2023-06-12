
(define-library
  (euphrates syntax-flatten-star)
  (export syntax-flatten*)
  (import
    (only (euphrates syntax-reverse) syntax-reverse)
    (only (scheme base)
          ...
          _
          begin
          define-syntax
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/syntax-flatten-star.scm")))
    (else (include "syntax-flatten-star.scm"))))
