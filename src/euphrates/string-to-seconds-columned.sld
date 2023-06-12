
(define-library
  (euphrates string-to-seconds-columned)
  (export string->seconds/columned)
  (import
    (only (euphrates const) const)
    (only (euphrates raisu) raisu)
    (only (euphrates range) range)
    (only (euphrates string-split-simple)
          string-split/simple)
    (only (scheme base)
          *
          +
          -
          >
          append
          begin
          car
          cdr
          define
          length
          let
          list-ref
          map
          null?
          number?
          quote
          string->number
          unless
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/string-to-seconds-columned.scm")))
    (else (include "string-to-seconds-columned.scm"))))
