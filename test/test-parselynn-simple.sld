
(define-library
  (test-parselynn-simple)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates assert-throw) assert-throw))
  (import
    (only (euphrates list-collapse) list-collapse))
  (import
    (only (euphrates
            parselynn-simple-run-with-error-handler)
          parselynn/simple:run/with-error-handler))
  (import
    (only (euphrates parselynn-simple)
          parselynn/simple))
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
             (include-from-path "test-parselynn-simple.scm")))
    (else (include "test-parselynn-simple.scm"))))
