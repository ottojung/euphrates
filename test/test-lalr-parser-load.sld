
(define-library
  (test-lalr-parser-load)
  (import
    (only (data parser-branching-glr)
          parser-branching-glr))
  (import
    (only (data parser-branching-lr)
          parser-branching-lr))
  (import
    (only (data parser-repeating-glr)
          parser-repeating-glr))
  (import
    (only (data parser-repeating-lr)
          parser-repeating-lr))
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates lalr-parser-load)
          lalr-parser-load))
  (import
    (only (euphrates lalr-parser-run)
          lalr-parser-run))
  (import
    (only (euphrates lalr-parser) make-lexical-token))
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
          define-values
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
          or
          pair?
          peek-char
          procedure?
          quote
          read-char
          reverse
          string
          string->number
          values))
  (import
    (only (scheme char)
          char-alphabetic?
          char-numeric?
          char-whitespace?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-lalr-parser-load.scm")))
    (else (include "test-lalr-parser-load.scm"))))
