
(define-library
  (euphrates read-all-port)
  (export read-all-port)
  (import
    (only (scheme base)
          begin
          cons
          define
          eof-object?
          if
          let
          list->string
          quote
          read-char
          reverse))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/read-all-port.scm")))
    (else (include "read-all-port.scm"))))
