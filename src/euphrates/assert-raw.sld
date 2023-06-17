
(define-library
  (euphrates assert-raw)
  (export assert/raw)
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          quasiquote
          quote
          syntax-rules
          unless
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/assert-raw.scm")))
    (else (include "assert-raw.scm"))))
