
(define-library
  (euphrates debugv)
  (export debugv)
  (import
    (only (euphrates const) const)
    (only (euphrates debug) debug)
    (only (euphrates list-intersperse)
          list-intersperse)
    (only (euphrates range) range)
    (only (scheme base)
          _
          apply
          begin
          define
          define-syntax
          length
          map
          quote
          reverse
          string-append
          syntax-rules)
    (only (srfi srfi-1) count))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/debugv.scm")))
    (else (include "debugv.scm"))))
