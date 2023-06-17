
(define-library
  (euphrates lazy-monad)
  (export lazy-monad)
  (import
    (only (euphrates dynamic-thread-async)
          dynamic-thread-async))
  (import
    (only (euphrates monad-make-no-cont-no-fin)
          monad-make/no-cont/no-fin))
  (import
    (only (euphrates monadstate)
          monadstate-arg
          monadstate-lval
          monadstate-qtags
          monadstate-ret/thunk))
  (import
    (only (scheme base)
          _
          begin
          call-with-values
          define
          if
          lambda
          list
          memq
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/lazy-monad.scm")))
    (else (include "lazy-monad.scm"))))
