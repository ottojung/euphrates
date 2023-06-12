
(define-library
  (euphrates list-span-n)
  (export list-span-n)
  (import
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
          or
          quote
          reverse
          values
          zero?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-span-n.scm")))
    (else (include "list-span-n.scm"))))
