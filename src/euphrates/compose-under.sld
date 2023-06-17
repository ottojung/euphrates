
(define-library
  (euphrates compose-under)
  (export compose-under)
  (import
    (only (euphrates syntax-reverse) syntax-reverse))
  (import
    (only (scheme base)
          _
          apply
          begin
          define-syntax
          lambda
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/compose-under.scm")))
    (else (include "compose-under.scm"))))
