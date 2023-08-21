
(define-library
  (benchmark-lalr-parser)
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
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates assert) assert))
  (import (only (euphrates ignore) ignore))
  (import
    (only (euphrates lalr-parser)
          lalr-parser
          make-lexical-token))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates stringf) stringf))
  (import
    (only (euphrates with-benchmark-simple)
          with-benchmark/simple))
  (import
    (only (scheme base)
          *
          +
          -
          /
          <
          =
          >
          begin
          car
          cdr
          cond
          define
          else
          equal?
          even?
          if
          lambda
          let
          list
          modulo
          null?
          procedure?
          quasiquote
          quote
          set!
          string->symbol
          unquote
          vector
          vector-length
          vector-ref
          when))
  (cond-expand
    (guile (import (only (srfi srfi-1) first)))
    (else (import (only (srfi 1) first))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "benchmark-lalr-parser.scm")))
    (else (include "benchmark-lalr-parser.scm"))))
