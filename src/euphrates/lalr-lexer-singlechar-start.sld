
(define-library
  (euphrates lalr-lexer-singlechar-start)
  (export lalr-lexer/singlechar-start)
  (import (only (euphrates assq-or) assq-or))
  (import
    (only (euphrates char-nocase-alphabetic-huh)
          char-nocase-alphabetic?))
  (import (only (euphrates hashmap) hashmap-ref))
  (import
    (only (euphrates lalr-lexer-singlechar-result-struct)
          make-lalr-lexer/singlechar-result-struct))
  (import
    (only (euphrates lalr-lexer-singlechar-struct)
          lalr-lexer/singlechar-struct:categories
          lalr-lexer/singlechar-struct:singleton-map))
  (import
    (only (euphrates lalr-parser) make-lexical-token))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates source-location)
          make-source-location))
  (import
    (only (scheme base)
          +
          >=
          _
          and
          begin
          cond
          define
          else
          eof-object
          eof-object?
          eq?
          equal?
          if
          lambda
          let
          list
          or
          port?
          quote
          read-char
          set!
          string
          string-length
          string-ref
          string?
          unless
          when))
  (import
    (only (scheme char)
          char-lower-case?
          char-numeric?
          char-upper-case?
          char-whitespace?))
  (cond-expand
    (guile (import (only (srfi srfi-1) any)))
    (else (import (only (srfi 1) any))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-lexer-singlechar-start.scm")))
    (else (include "lalr-lexer-singlechar-start.scm"))))
