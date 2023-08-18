
(define-library
  (test-lalr-parser-standardcases)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import (only (euphrates ignore) ignore))
  (import
    (only (euphrates lalr-parser)
          lalr-parser
          make-lexical-token))
  (import (only (euphrates raisu-star) raisu*))
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
