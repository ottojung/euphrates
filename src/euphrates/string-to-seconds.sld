
(define-library
  (euphrates string-to-seconds)
  (export string->seconds)
  (import (only (euphrates assq-or) assq-or))
  (import
    (only (euphrates compose-under-seq)
          compose-under-seq))
  (import
    (only (euphrates compose-under) compose-under))
  (import (only (euphrates compose) compose))
  (import
    (only (euphrates group-by-sequential)
          group-by/sequential))
  (import (only (euphrates negate) negate))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates string-null-or-whitespace-p)
          string-null-or-whitespace?))
  (import
    (only (scheme base)
          *
          +
          and
          begin
          car
          cdr
          cond
          define
          else
          equal?
          if
          integer?
          lambda
          let
          list->string
          map
          memq
          min
          null?
          number?
          or
          quasiquote
          quote
          string->list
          string->number
          string->symbol
          unquote))
  (import
    (only (scheme char)
          char-numeric?
          char-whitespace?
          string-downcase))
  (import
    (only (scheme r5rs)
          exact->inexact
          inexact->exact))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter last second)))
    (else (import (only (srfi 1) filter last second))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/string-to-seconds.scm")))
    (else (include "string-to-seconds.scm"))))
