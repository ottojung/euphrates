
(define-library
  (euphrates compose-under-par)
  (export compose-under-par)
  (import
    (only (euphrates syntax-reverse) syntax-reverse)
    (only (scheme base)
          _
          begin
          define-syntax
          lambda
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/compose-under-par.scm")))
    (else (include "compose-under-par.scm"))))
