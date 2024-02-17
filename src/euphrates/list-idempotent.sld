
(define-library
  (euphrates list-idempotent)
  (export list-idempotent)
  (import
    (only (euphrates list-or-map) list-or-map))
  (import
    (only (scheme base)
          begin
          car
          cdr
          cond
          cons
          define
          else
          lambda
          let
          null?
          quote
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-idempotent.scm")))
    (else (include "list-idempotent.scm"))))
