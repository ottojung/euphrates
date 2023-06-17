
(define-library
  (euphrates stringf)
  (export stringf)
  (import
    (only (euphrates call-with-output-string)
          call-with-output-string))
  (import
    (only (scheme base)
          begin
          cadr
          car
          case
          cddr
          cdr
          char=?
          cond
          define
          else
          error
          get-output-string
          if
          lambda
          let
          newline
          null?
          quote
          string->list
          write-char))
  (import (only (scheme write) display write))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/stringf.scm")))
    (else (include "stringf.scm"))))
