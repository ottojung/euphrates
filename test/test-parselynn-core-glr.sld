
(define-library
  (test-parselynn-core-glr)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates ignore) ignore))
  (import
    (only (euphrates parselynn-core-conflict-handler-p)
          parselynn:core:conflict-handler/p))
  (import
    (only (euphrates parselynn-core) parselynn:core))
  (import
    (only (euphrates parselynn-run) parselynn-run))
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
          parameterize
          quasiquote
          quote
          set!))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "test-parselynn-core-glr.scm")))
    (else (include "test-parselynn-core-glr.scm"))))
