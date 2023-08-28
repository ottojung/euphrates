
(define-library
  (euphrates lalr-lexer-singlechar)
  (export make-lalr-lexer/singlechar-factory)
  (import (only (euphrates fn-pair) fn-pair))
  (import
    (only (euphrates hashmap)
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates lalr-parser) make-lexical-token))
  (import
    (only (euphrates list-length-eq) list-length=))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates source-location)
          make-source-location))
  (import
    (only (scheme base)
          +
          >=
          _
          begin
          car
          char?
          cond
          define
          else
          eof-object
          eof-object?
          equal?
          for-each
          if
          lambda
          let
          list
          port?
          quote
          read-char
          set!
          string->list
          string-length
          string-ref
          string?
          unless
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-lexer-singlechar.scm")))
    (else (include "lalr-lexer-singlechar.scm"))))
