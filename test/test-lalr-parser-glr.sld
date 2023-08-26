
(define-library
  (test-lalr-parser-glr)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates ignore) ignore))
  (import
    (only (euphrates lalr-parser-run)
          lalr-parser-run))
  (import
    (only (euphrates lalr-parser) lalr-parser))
  (import
    (only (scheme base)
          begin
          car
          cdr
          cons
          define
          else
          if
          lambda
          length
          let
          null?
          quasiquote
          quote
          set!
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-lalr-parser-glr.scm")))
    (else (include "test-lalr-parser-glr.scm"))))
