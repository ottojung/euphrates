
(define-library
  (test-parselynn-standardcases)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import (only (euphrates assert) assert))
  (import (only (euphrates ignore) ignore))
  (import
    (only (euphrates parselynn-run-with-error-handler)
          parselynn-run/with-error-handler))
  (import
    (only (euphrates parselynn-run)
          parselynn-run))
  (import
    (only (euphrates parselynn)
          parselynn
          make-lexical-token))
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
          _
          and
          apply
          begin
          char=?
          char?
          cond
          cons
          define
          else
          eof-object?
          for-each
          if
          lambda
          let
          let*
          letrec
          list
          make-parameter
          or
          parameterize
          peek-char
          quasiquote
          quote
          read-char
          reverse
          set!
          string
          string->number
          unless
          unquote
          unquote-splicing))
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
               "test-parselynn-standardcases.scm")))
    (else (include "test-parselynn-standardcases.scm"))))
