
(define-library
  (euphrates print-in-frame)
  (export print-in-frame)
  (import
    (only (euphrates list-span-n) list-span-n)
    (only (euphrates raisu) raisu)
    (only (euphrates replicate) replicate)
    (only (euphrates string-to-lines) string->lines)
    (only (scheme base)
          +
          -
          =
          >
          begin
          car
          cdr
          cond
          cons
          define
          define-values
          else
          equal?
          if
          let
          let*
          list
          list->string
          max
          newline
          null?
          or
          pair?
          quasiquote
          quote
          string
          string->list
          string-length
          string?
          unless
          unquote
          when)
    (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/print-in-frame.scm")))
    (else (include "print-in-frame.scm"))))
