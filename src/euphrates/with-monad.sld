
(define-library
  (euphrates with-monad)
  (export with-monad)
  (import
    (only (euphrates monad-apply) monad-apply)
    (only (euphrates monad-current-p)
          monad-current/p)
    (only (euphrates monad-transformer-current-p)
          monad-transformer-current/p)
    (only (euphrates monadfinobj) monadfinobj)
    (only (euphrates monadstate) monadstate-arg)
    (only (scheme base)
          _
          begin
          call-with-values
          define-syntax
          if
          lambda
          let*
          parameterize
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/with-monad.scm")))
    (else (include "with-monad.scm"))))
