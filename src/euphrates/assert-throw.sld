
(define-library
  (euphrates assert-throw)
  (export assert-throw)
  (import
    (only (euphrates catchu-case) catchu-case))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          _
          begin
          define-syntax
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
