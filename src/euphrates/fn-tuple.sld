
(define-library
  (euphrates fn-tuple)
  (export fn-tuple)
  (import
    (only (euphrates raisu) raisu)
    (only (scheme base)
          begin
          define
          if
          lambda
          map
          null?
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/fn-tuple.scm")))
    (else (include "fn-tuple.scm"))))
