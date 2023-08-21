
(define-library
  (test-lalr-parser-glr)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates ignore) ignore))
  (import
    (only (euphrates lalr-parser) lalr-parser))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          begin
          car
          cdr
          cons
          current-error-port
          current-output-port
          define
          else
          for-each
          if
          lambda
          length
          let
          newline
          null?
          parameterize
          quasiquote
          quote
          set!
          syntax-error
          unquote))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (srfi srfi-26) cut)))
    (else (import (only (srfi 26) cut))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-lalr-parser-glr.scm")))
    (else (include "test-lalr-parser-glr.scm"))))
