
(define-library
  (test-lalr-parser-output)
  (import (only (euphrates assert) assert))
  (import
    (only (euphrates lalr-parser) lalr-parser))
  (import
    (only (euphrates list-length-geq-q)
          list-length=<?))
  (import
    (only (scheme base)
          *
          +
          -
          /
          =
          begin
          define
          let
          list?
          quasiquote
          set!
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-lalr-parser-output.scm")))
    (else (include "test-lalr-parser-output.scm"))))
