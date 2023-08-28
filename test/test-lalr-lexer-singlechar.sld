
(define-library
  (test-lalr-lexer-singlechar)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates lalr-lexer-singlechar)
          make-lalr-lexer/singlechar-factory))
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
          current-input-port
          define
          equal?
          if
          let
          quasiquote
          quote
          vector))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-lalr-lexer-singlechar.scm")))
    (else (include "test-lalr-lexer-singlechar.scm"))))
