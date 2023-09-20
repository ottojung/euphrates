
(define-library
  (euphrates lalr-lexer-singlechar)
  (export make-lalr-lexer/singlechar)
  (import
    (only (euphrates apply-until-fixpoint)
          apply-until-fixpoint))
  (import (only (euphrates assq-or) assq-or))
  (import (only (euphrates comp) comp))
  (import
    (only (euphrates define-pair) define-pair))
  (import
    (only (euphrates hashmap)
          hashmap->alist
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates hashset)
          hashset->list
          hashset-add!
          hashset-has?
          list->hashset
          make-hashset))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates lalr-lexer-singlechar-result-struct)
          make-lalr-lexer/singlechar-result-struct))
  (import
    (only (euphrates lalr-lexer-singlechar-struct)
          make-lalr-lexer/singlechar-struct))
  (import
    (only (euphrates lalr-parser) make-lexical-token))
  (import
    (only (euphrates list-deduplicate)
          list-deduplicate/reverse))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import
    (only (euphrates list-or-map) list-or-map))
  (import
    (only (euphrates list-singleton-q)
          list-singleton?))
  (import (only (euphrates negate) negate))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates source-location)
          make-source-location))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          +
          <
          =
          >=
          _
          and
          append
          apply
          begin
          car
          cdr
          char?
          cond
          cons
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
          not
          null?
          or
          port?
          quasiquote
          quote
          read-char
          set!
          string
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
