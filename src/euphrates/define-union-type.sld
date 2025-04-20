
(define-library
  (euphrates define-union-type)
  (export define-union-type)
  (import
    (only (euphrates compose-under) compose-under))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates syntax-reverse) syntax-reverse))
  (import
    (only (scheme base)
          _
          begin
          case
          cond
          define
          define-syntax
          else
          lambda
          let
          list
          or
          quote
          syntax-error
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/define-union-type.scm")))
    (else (include "define-union-type.scm"))))
