
(define-library
  (euphrates fprintf)
  (export fprintf)
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
          if
          let
          newline
          null?
          quote
          string->list
          values
          write-char))
  (import (only (scheme write) display write))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/fprintf.scm")))
    (else (include "fprintf.scm"))))
