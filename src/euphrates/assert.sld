
(define-library
  (euphrates assert)
  (export assert)
  (import
    (only (euphrates assert-raw) assert/raw)
    (only (euphrates raisu) raisu)
    (only (euphrates reversed-args-f)
          reversed-args-f)
    (only (euphrates stringf) stringf)
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
          unquote)
    (only (srfi srfi-1) last))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/assert.scm")))
    (else (include "assert.scm"))))
