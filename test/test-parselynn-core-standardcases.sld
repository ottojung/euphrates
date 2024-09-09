
(define-library
  (test-parselynn-core-standardcases)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import (only (euphrates assert) assert))
  (import (only (euphrates debug) debug))
  (import (only (euphrates ignore) ignore))
  (import
    (only (euphrates parselynn-core-conflict-handler-p)
          parselynn:core:conflict-handler/p))
  (import
    (only (euphrates parselynn-core) parselynn:core))
  (import
    (only (euphrates parselynn-end-of-input)
          parselynn:end-of-input))
  (import
    (only (euphrates parselynn-run-with-error-handler)
          parselynn-run/with-error-handler))
  (import
    (only (euphrates parselynn-run) parselynn-run))
  (import
    (only (euphrates parselynn-token)
          parselynn:token:make))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates source-location)
          make-source-location))
  (import (only (euphrates stringf) stringf))
  (import
    (only (euphrates with-string-as-input)
          with-string-as-input))
  (import
    (only (scheme base)
          *
          +
          -
          /
          =
          >
          _
          and
          apply
          begin
          car
          cdr
          char=?
          char?
          cond
          cons
          define
          define-syntax
          else
          eof-object?
          equal?
          for-each
          if
          lambda
          let
          let*
          letrec
          list
          list->vector
          make-parameter
          map
          modulo
          null?
          or
          pair?
          parameterize
          peek-char
          quasiquote
          quote
          read-char
          reverse
          set!
          string
          string->number
          syntax-rules
          unless
          unquote
          unquote-splicing
          vector-ref
          when))
  (import
    (only (scheme char)
          char-alphabetic?
          char-numeric?
          char-whitespace?))
  (cond-expand
    (guile (import (only (srfi srfi-1) first iota)))
    (else (import (only (srfi 1) first iota))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-parselynn-core-standardcases.scm")))
    (else (include "test-parselynn-core-standardcases.scm"))))
