
(define-library
  (test-lalr-parser-standardcases)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates lalr-parser)
          lalr-parser
          make-lexical-token
          make-source-location))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates stringf) stringf))
  (import
    (only (euphrates with-lalr-parser-conflict-handler)
          with-lalr-parser-conflict-handler))
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
          car
          cdr
          char=?
          char?
          cond
          cons
          define
          else
          eof-object?
          if
          lambda
          let
          let*
          letrec
          list
          or
          peek-char
          quasiquote
          quote
          read-char
          reverse
          string
          string->number
          unquote
          unquote-splicing))
  (import
    (only (scheme char)
          char-alphabetic?
          char-numeric?
          char-whitespace?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-lalr-parser-standardcases.scm")))
    (else (include "test-lalr-parser-standardcases.scm"))))
