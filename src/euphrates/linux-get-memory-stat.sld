
(define-library
  (euphrates linux-get-memory-stat)
  (export
    linux-get-memory-stat
    linux-get-memory-free%)
  (import (only (euphrates comp) comp))
  (import (only (euphrates list-last) list-last))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates read-lines) read/lines))
  (import
    (only (euphrates string-to-words) string->words))
  (import
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
          when))
  (import (only (scheme cxr) caddr))
  (import (only (scheme r5rs) exact->inexact))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/linux-get-memory-stat.scm")))
    (else (include "linux-get-memory-stat.scm"))))
