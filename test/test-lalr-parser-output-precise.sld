
(define-library
  (test-lalr-parser-output-precise)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates comp) comp))
  (import (only (euphrates ignore) ignore))
  (import
    (only (euphrates lalr-parser) lalr-parser))
  (import
    (only (euphrates read-string-file)
          read-string-file))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          *
          +
          -
          /
          =
          begin
          define
          for-each
          lambda
          let
          newline
          quasiquote
          quote
          string->symbol
          unquote
          unquote-splicing))
  (import
    (only (scheme file) call-with-output-file))
  (import (only (scheme write) write))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-lalr-parser-output-precise.scm")))
    (else (include "test-lalr-parser-output-precise.scm"))))
