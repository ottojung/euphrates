
(define-library
  (euphrates linux-get-memory-stat)
  (export
    linux-get-memory-stat
    linux-get-memory-free%)
  (import
    (only (euphrates comp) comp)
    (only (euphrates list-last) list-last)
    (only (euphrates raisu) raisu)
    (only (euphrates read-lines) read/lines)
    (only (euphrates string-to-words) string->words)
    (only (scheme base)
          /
          =
          and
          assoc
          begin
          cadr
          car
          cdr
          define
          equal?
          integer?
          length
          let*
          map
          member
          not
          null?
          or
          quasiquote
          quote
          string->number
          unless
          unquote
          when)
    (only (scheme cxr) caddr)
    (only (scheme r5rs) exact->inexact)
    (only (srfi srfi-1) filter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/linux-get-memory-stat.scm")))
    (else (include "linux-get-memory-stat.scm"))))
