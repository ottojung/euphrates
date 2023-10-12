
(define-library
  (euphrates
    parselynn-singlechar-result-as-iterator)
  (export parselynn/singlechar-result:as-iterator)
  (import (only (euphrates assq-or) assq-or))
  (import
    (only (euphrates char-nocase-alphabetic-huh)
          char-nocase-alphabetic?))
  (import (only (euphrates hashmap) hashmap-ref))
  (import
    (only (euphrates parselynn-singlechar-result-struct)
          parselynn/singlechar-result-struct:input
          parselynn/singlechar-result-struct:input-type
          parselynn/singlechar-result-struct:lexer))
  (import
    (only (euphrates parselynn-singlechar-struct)
          parselynn/singlechar-struct:categories
          parselynn/singlechar-struct:singleton-map))
  (import
    (only (euphrates parselynn) make-lexical-token))
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
               "euphrates/parselynn-singlechar-result-as-iterator.scm")))
    (else (include
            "parselynn-singlechar-result-as-iterator.scm"))))
