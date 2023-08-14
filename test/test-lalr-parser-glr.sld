
(define-library
  (test-lalr-parser-glr)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates lalr-parser)
          glr-driver
          lalr-parser
          lexical-token-source
          lexical-token-value
          lexical-token?))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          begin
          car
          cdr
          current-error-port
          current-output-port
          define
          else
          for-each
          if
          lambda
          length
          let
          let*
          list-ref
          newline
          null?
          parameterize
          quote
          set!
          syntax-error
          vector))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (srfi srfi-26) cut)))
    (else (import (only (srfi 26) cut))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-lalr-parser-glr.scm")))
    (else (include "test-lalr-parser-glr.scm"))))
