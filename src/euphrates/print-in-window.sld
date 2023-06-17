
(define-library
  (euphrates print-in-window)
  (export print-in-window)
  (import
    (only (euphrates list-span-n) list-span-n))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates replicate) replicate))
  (import
    (only (euphrates string-to-lines) string->lines))
  (import
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
          unquote))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/print-in-window.scm")))
    (else (include "print-in-window.scm"))))
