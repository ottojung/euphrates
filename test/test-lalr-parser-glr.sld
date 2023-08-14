
(define-library
  (test-lalr-parser-glr)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates lalr-parser)
          lalr-parser
          lexical-token-category
          lexical-token-source
          lexical-token-value
          lexical-token?))
  (import (only (euphrates raisu) raisu))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          *
          -
          <
          =
          >=
          _
          and
          assoc
          assv
          begin
          cadr
          car
          cdar
          cdr
          cond
          cons
          current-error-port
          current-output-port
          define
          else
          eq?
          for-each
          if
          lambda
          length
          let
          let*
          list
          list-ref
          make-vector
          newline
          not
          null?
          pair?
          parameterize
          quote
          reverse
          set!
          symbol?
          syntax-error
          vector
          vector-length
          vector-ref
          vector-set!
          vector?))
  (import (only (scheme cxr) cadar))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (srfi srfi-1) drop take-right)))
    (else (import (only (srfi 1) drop take-right))))
  (cond-expand
    (guile (import (only (srfi srfi-26) cut)))
    (else (import (only (srfi 26) cut))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-lalr-parser-glr.scm")))
    (else (include "test-lalr-parser-glr.scm"))))
