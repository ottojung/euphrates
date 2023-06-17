
(define-library
  (euphrates assert)
  (export assert)
  (import (only (euphrates assert-raw) assert/raw))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates reversed-args-f)
          reversed-args-f))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          _
          begin
          cons
          define-syntax
          let
          list
          quasiquote
          quote
          syntax-rules
          unless
          unquote))
  (cond-expand
    (guile (import (only (srfi srfi-1) last)))
    (else (import (only (srfi 1) last))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/assert.scm")))
    (else (include "assert.scm"))))
