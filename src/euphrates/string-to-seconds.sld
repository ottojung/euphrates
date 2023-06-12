
(define-library
  (euphrates string-to-seconds)
  (export string->seconds)
  (import
    (only (euphrates raisu) raisu)
    (only (scheme base)
          *
          +
          and
          begin
          car
          case
          cdr
          cons
          define
          else
          if
          let
          let*
          list->string
          null?
          or
          quote
          reverse
          string->list
          string->number))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/string-to-seconds.scm")))
    (else (include "string-to-seconds.scm"))))
