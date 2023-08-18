
(define-library
  (test-lalr-lexer-latin)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates lalr-lexer-latin-digits)
          lalr-lexer/latin/digits))
  (import
    (only (euphrates lalr-lexer-latin-letters)
          lalr-lexer/latin/letters))
  (import
    (only (euphrates lalr-lexer-latin)
          make-lalr-lexer/latin))
  (import
    (only (euphrates lalr-lexr-latin-tokens)
          lalr-lexr/latin-tokens))
  (import
    (only (euphrates lalr-parser) lalr-parser))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          begin
          car
          cdr
          define
          list
          quasiquote
          quote
          unquote
          unquote-splicing))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-lalr-lexer-latin.scm")))
    (else (include "test-lalr-lexer-latin.scm"))))
