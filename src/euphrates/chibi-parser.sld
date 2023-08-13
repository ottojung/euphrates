
(define-library
  (euphrates chibi-parser)
  (export
    chibi-parse-integer
    chibi-parse-unsigned-integer
    chibi-parse-c-integer
    define-grammar
    chibi-parse
    chibi-parse-fully
    chibi-parse-real
    chibi-parse-complex
    chibi-parse-identifier
    chibi-parse-delimited
    chibi-parse-separated
    chibi-parse-records
    chibi-parse-space
    chibi-parse-binary-op
    chibi-parse-ipv4-address
    chibi-parse-ipv6-address
    chibi-parse-ip-address
    chibi-parse-domain
    chibi-parse-common-domain
    chibi-parse-email
    chibi-parse-uri
    char-hex-digit?
    char-octal-digit?)
  (import
    (only (scheme base)
          *
          +
          -
          ...
          /
          <
          <=
          =
          =>
          >
          >=
          and
          append
          apply
          assoc
          assq
          assv
          begin
          cadr
          car
          case
          cddr
          cdr
          char->integer
          char<=?
          char?
          close-input-port
          cond
          cons
          define
          define-record-type
          define-syntax
          do
          else
          eof-object?
          eq?
          eqv?
          error
          if
          lambda
          let
          let*
          letrec
          list
          list->string
          list?
          make-string
          make-vector
          map
          memv
          min
          negative?
          not
          null?
          open-input-string
          or
          pair?
          procedure?
          quasiquote
          quote
          read-char
          reverse
          set!
          set-cdr!
          string->list
          string->number
          string->symbol
          string-append
          string-length
          string-set!
          string?
          syntax-rules
          unquote
          unquote-splicing
          vector-length
          vector-ref
          vector-set!
          zero?))
  (import
    (only (scheme char)
          char-alphabetic?
          char-downcase
          char-lower-case?
          char-numeric?
          char-upper-case?
          char-whitespace?))
  (import (only (scheme file) open-input-file))
  (import (only (scheme lazy) delay force))
  (cond-expand
    (guile (import (only (srfi srfi-1) any)))
    (else (import (only (srfi 1) any))))
  (cond-expand
    (guile (import
             (only (srfi srfi-14)
                   char-set
                   char-set-complement
                   char-set-contains?
                   char-set-difference
                   char-set-intersection
                   char-set-union
                   char-set?
                   string->char-set
                   ucs-range->char-set)))
    (else (import
            (only (srfi 14)
                  char-set
                  char-set-complement
                  char-set-contains?
                  char-set-difference
                  char-set-intersection
                  char-set-union
                  char-set?
                  string->char-set
                  ucs-range->char-set))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/chibi-parser.scm")))
    (else (include "chibi-parser.scm"))))
