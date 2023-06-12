
(define-library
  (euphrates monad-make-hook)
  (export monad-make/hook)
  (import
    (only (euphrates monad-make-no-cont-no-fin)
          monad-make/no-cont/no-fin)
    (only (euphrates monadstate-current-p)
          monadstate-current/p)
    (only (euphrates monadstate)
          monadstate-args
          monadstate-qtags
          monadstate-ret)
    (only (scheme base)
          _
          apply
          begin
          call-with-values
          define
          if
          lambda
          let
          parameterize
          procedure?
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/monad-make-hook.scm")))
    (else (include "monad-make-hook.scm"))))
