
(define-library
  (euphrates debugs)
  (export debugs)
  (import (only (euphrates debug) debug))
  (import
    (only (euphrates pretty-print) pretty-print))
  (import
    (only (euphrates serialization-short)
          serialize/short))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
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
           (begin
             (include-from-path "euphrates/debugs.scm")))
    (else (include "debugs.scm"))))
