
(define-library
  (euphrates call-with-finally)
  (export call-with-finally)
  (import
    (only (euphrates catch-any) catch-any)
    (only (euphrates raisu) raisu)
    (only (scheme base)
          apply
          begin
          define
          lambda
          let
          set!
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/call-with-finally.scm")))
    (else (include "call-with-finally.scm"))))
