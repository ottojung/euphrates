
(define-library
  (euphrates read-lines)
  (export read/lines)
  (import
    (only (scheme base)
          +
          begin
          close-port
          cond
          cond-expand
          cons
          define
          else
          eof-object?
          if
          let
          port?
          quote
          read-line
          string?
          when))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (except (guile) cond-expand))
           (begin
             (include-from-path "euphrates/read-lines.scm")))
    (else (include "read-lines.scm"))))
