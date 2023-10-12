
(define-library
  (test-parselynn-glr)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates ignore) ignore))
  (import
    (only (euphrates parselynn-run)
          parselynn-run))
  (import
    (only (euphrates parselynn) parselynn))
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
             (include-from-path "test-parselynn-glr.scm")))
    (else (include "test-parselynn-glr.scm"))))
