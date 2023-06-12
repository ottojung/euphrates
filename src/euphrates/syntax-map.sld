
(define-library
  (euphrates syntax-map)
  (export syntax-map)
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
             (include-from-path "euphrates/syntax-map.scm")))
    (else (include "syntax-map.scm"))))
