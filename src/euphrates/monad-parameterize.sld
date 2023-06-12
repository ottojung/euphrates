
(define-library
  (euphrates monad-parameterize)
  (export
    monad-parameterize
    with-monad-left
    with-monad-right)
  (import
    (only (euphrates monad-compose) monad-compose)
    (only (euphrates monad-transformer-current-p)
          monad-transformer-current/p)
    (only (scheme base)
          _
          begin
          define-syntax
          if
          lambda
          let
          parameterize
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/monad-parameterize.scm")))
    (else (include "monad-parameterize.scm"))))
