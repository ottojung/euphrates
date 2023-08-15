
(define-library
  (test-lalr-parser-calc)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates lalr-parser)
          lalr-parser
          lexical-token-category
          lexical-token-source
          lexical-token-value
          lexical-token?
          make-lexical-token
          make-source-location
          source-location-column
          source-location-line
          source-location?))
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
          =
          and
          apply
          assq
          begin
          call-with-current-continuation
          car
          cdr
          char=?
          cond
          cons
          current-input-port
          define
          else
          eof-object?
          error
          expt
          for-each
          if
          lambda
          let
          let*
          letrec
          list
          newline
          not
          number?
          or
          pair?
          peek-char
          procedure?
          quasiquote
          quote
          read-char
          reverse
          set!
          set-cdr!
          string
          string->number
          string->symbol
          unquote))
  (import
    (only (scheme char)
          char-alphabetic?
          char-numeric?))
  (import (only (scheme inexact) cos sin sqrt tan))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-lalr-parser-calc.scm")))
    (else (include "test-lalr-parser-calc.scm"))))
