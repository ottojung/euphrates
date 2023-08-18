
(define-library
  (test-lalr-lexer-irregex)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates lalr-lexer-irregex)
          make-lalr-lexer/irregex-factory))
  (import
    (only (euphrates lalr-parser)
          lexical-token-category
          lexical-token-source
          lexical-token-value))
  (import
    (only (euphrates source-location)
          source-location-column
          source-location-length
          source-location-line
          source-location-offset))
  (import
    (only (euphrates with-string-as-input)
          with-string-as-input))
  (import
    (only (scheme base)
          begin
          cons
          define
          equal?
          if
          let
          or
          quasiquote
          quote
          vector))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-lalr-lexer-irregex.scm")))
    (else (include "test-lalr-lexer-irregex.scm"))))
