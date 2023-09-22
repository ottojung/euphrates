
(define-library
  (test-lalr-parser-simple-extend)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates lalr-parser-simple-extend)
          lalr-parser/simple:extend))
  (import
    (only (euphrates
            lalr-parser-simple-run-with-error-handler)
          lalr-parser/simple:run/with-error-handler))
  (import
    (only (euphrates lalr-parser-simple)
          lalr-parser/simple))
  (import
    (only (euphrates list-collapse) list-collapse))
  (import (only (euphrates raisu-star) raisu*))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          /
          =
          _
          apply
          begin
          define
          define-syntax
          if
          let
          list
          list?
          quasiquote
          quote
          string-append
          string?
          syntax-rules
          unquote))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-lalr-parser-simple-extend.scm")))
    (else (include "test-lalr-parser-simple-extend.scm"))))
