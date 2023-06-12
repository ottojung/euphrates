
(define-library
  (euphrates debugs)
  (export debugs)
  (import
    (only (euphrates debug) debug)
    (only (euphrates serialization-short)
          serialize/short)
    (only (euphrates with-output-to-string)
          with-output-to-string)
    (only (scheme base)
          _
          begin
          define-syntax
          if
          let*
          pair?
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (only (ice-9 pretty-print) pretty-print))
           (begin
             (include-from-path "euphrates/debugs.scm")))
    (else (include "debugs.scm"))))
