
(define-library
  (euphrates assert-throw)
  (export assert-throw)
  (import (only (euphrates catch-any) catch-any))
  (import
    (only (euphrates catch-specific) catch-specific))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          eq?
          if
          lambda
          let
          quote
          set!
          syntax-rules
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/assert-throw.scm")))
    (else (include "assert-throw.scm"))))
