
(define-library
  (test-lalr-parser-largecases)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import (only (euphrates const) const))
  (import (only (euphrates ignore) ignore))
  (import
    (only (euphrates lalr-parser-run-with-error-handler)
          lalr-parser-run/with-error-handler))
  (import
    (only (euphrates lalr-parser-run)
          lalr-parser-run))
  (import
    (only (euphrates lalr-parser)
          lalr-parser
          lexical-token-value
          make-lexical-token))
  (import (only (euphrates raisu) raisu))
  (import
    (only (euphrates source-location)
          make-source-location))
  (import (only (euphrates stringf) stringf))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (euphrates with-string-as-input)
          with-string-as-input))
  (import
    (only (scheme base)
          *
          +
          -
          /
          <
          =
          >
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
          equal?
          if
          lambda
          let
          let*
          letrec
          list
          modulo
          null?
          or
          peek-char
          procedure?
          quasiquote
          quote
          read-char
          reverse
          set!
          string
          string->number
          unless
          unquote
          vector-length
          vector-ref
          when))
  (import
    (only (scheme char)
          char-alphabetic?
          char-numeric?
          char-whitespace?))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-lalr-parser-largecases.scm")))
    (else (include "test-lalr-parser-largecases.scm"))))
