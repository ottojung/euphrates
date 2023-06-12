
(define-library
  (euphrates list-span)
  (export list-span)
  (import
    (only (euphrates raisu) raisu)
    (only (scheme base)
          -
          begin
          car
          cdr
          cons
          define
          if
          let
          null?
          quote
          reverse
          values
          zero?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-span.scm")))
    (else (include "list-span.scm"))))
