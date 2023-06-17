
(define-library
  (euphrates call-with-finally)
  (export call-with-finally)
  (import (only (euphrates catch-any) catch-any))
  (import (only (euphrates raisu) raisu))
  (import
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
