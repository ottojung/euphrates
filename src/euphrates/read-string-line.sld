
(define-library
  (euphrates read-string-line)
  (export read-string-line)
  (import
    (only (scheme base)
          begin
          cond
          cond-expand
          cons
          current-input-port
          define
          else
          eof-object?
          equal?
          if
          let
          list->string
          null?
          quote
          reverse)
    (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (ice-9 textual-ports))
           (begin
             (include-from-path
               "euphrates/read-string-line.scm")))
    (else (include "read-string-line.scm"))))
