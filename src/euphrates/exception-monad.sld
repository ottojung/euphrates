
(define-library
  (euphrates exception-monad)
  (export exception-monad)
  (import (only (euphrates catch-any) catch-any))
  (import (only (euphrates cons-bang) cons!))
  (import
    (only (euphrates monad-make-no-cont)
          monad-make/no-cont))
  (import
    (only (euphrates monadfinobj) monadfinobj?))
  (import
    (only (euphrates monadstate)
          monadstate-arg
          monadstate-lval
          monadstate-qtags
          monadstate-ret
          monadstate-ret/thunk))
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          _
          apply
          begin
          call-with-values
          define
          if
          lambda
          let
          memq
          null?
          or
          quote
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/exception-monad.scm")))
    (else (include "exception-monad.scm"))))
