
(define-library
  (euphrates lalr-lexer-singlechar)
  (export make-lalr-lexer/singlechar-factory)
  (import (only (euphrates comp) comp))
  (import (only (euphrates fn-pair) fn-pair))
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import (only (euphrates hashset) hashset->list))
  (import
    (only (euphrates lalr-parser) make-lexical-token))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import
    (only (euphrates list-or-map) list-or-map))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates source-location)
          make-source-location))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          +
          >=
          _
          and
          append
          begin
          car
          cdr
          char?
          cond
          define
          define-values
          else
          eof-object
          eof-object?
          eq?
          equal?
          for-each
          if
          lambda
          let
          list
          map
          member
          not
          null?
          or
          port?
          quasiquote
          quote
          read-char
          set!
          string->list
          string->symbol
          string-append
          string-length
          string-ref
          string?
          unless
          unquote
          unquote-splicing
          values
          when))
  (import
    (only (scheme char)
          char-alphabetic?
          char-lower-case?
          char-numeric?
          char-upper-case?
          char-whitespace?))
  (cond-expand
    (guile (import (only (srfi srfi-1) any filter)))
    (else (import (only (srfi 1) any filter))))
  (cond-expand
    (guile (import (only (srfi srfi-13) string-prefix?)))
    (else (import (only (srfi 13) string-prefix?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-lexer-singlechar.scm")))
    (else (include "lalr-lexer-singlechar.scm"))))
