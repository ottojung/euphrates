
(define-library
  (euphrates filter-monad)
  (export filter-monad)
  (import
    (only (euphrates list-or-map) list-or-map)
    (only (euphrates raisu) raisu)
    (only (euphrates replacement-monad)
          replacement-monad)
    (only (scheme base)
          _
          begin
          define
          if
          lambda
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/filter-monad.scm")))
    (else (include "filter-monad.scm"))))
