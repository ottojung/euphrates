
(define-library
  (euphrates catch-any)
  (export catch-any)
  (import
    (only (scheme base)
          begin
          cond-expand
          define
          lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path catch))
           (begin
             (include-from-path "euphrates/catch-any.scm")))
    (else (include "catch-any.scm"))))
