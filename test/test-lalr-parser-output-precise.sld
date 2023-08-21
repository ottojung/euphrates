
(define-library
  (test-lalr-parser-output-precise)
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
  (import (only (euphrates comp) comp))
  (import (only (euphrates ignore) ignore))
  (import
    (only (euphrates lalr-parser)
          lalr-parser
          make-lexical-token))
  (import (only (euphrates printf) printf))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates read-list) read-list))
  (import
    (only (euphrates source-location)
          make-source-location))
  (import
    (only (euphrates stack)
          stack->list
          stack-empty?
          stack-make
          stack-push!))
  (import (only (euphrates stringf) stringf))
  (import (only (euphrates tilda-a) ~a))
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
          newline
          or
          pair?
          peek-char
          procedure?
          quasiquote
          quote
          read-char
          reverse
          string
          string->number
          string->symbol
          unless
          unquote
          values
          vector))
  (import
    (only (scheme char)
          char-alphabetic?
          char-numeric?
          char-whitespace?))
  (import
    (only (scheme file)
          call-with-input-file
          call-with-output-file
          file-exists?))
  (import (only (scheme write) write))
  (cond-expand
    (guile (import (only (srfi srfi-1) first)))
    (else (import (only (srfi 1) first))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-lalr-parser-output-precise.scm")))
    (else (include "test-lalr-parser-output-precise.scm"))))
