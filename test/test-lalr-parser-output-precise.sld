
(define-library
  (test-lalr-parser-output-precise)
  (import (only (euphrates assert) assert))
  (import (only (euphrates comp) comp))
  (import (only (euphrates ignore) ignore))
  (import
    (only (euphrates lalr-parser) lalr-parser))
  (import (only (euphrates printf) printf))
  (import
    (only (euphrates read-string-file)
          read-string-file))
  (import
    (only (euphrates stack)
          stack->list
          stack-empty?
          stack-make
          stack-push!))
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
          equal?
          for-each
          if
          lambda
          let
          newline
          quasiquote
          quote
          string->symbol
          unless
          unquote))
  (import
    (only (scheme file)
          call-with-output-file
          file-exists?))
  (import (only (scheme write) write))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-lalr-parser-output-precise.scm")))
    (else (include "test-lalr-parser-output-precise.scm"))))
