
(define-library
  (test-lalr-parser-simple)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates lalr-parser-simple)
          lalr-parser/simple))
  (import
    (only (euphrates list-collapse) list-collapse))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          *
          /
          =
          apply
          begin
          define
          if
          let
          list
          list?
          or
          quasiquote
          quote
          string-append
          string?
          unquote))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-lalr-parser-simple.scm")))
    (else (include "test-lalr-parser-simple.scm"))))
