
(define-library
  (euphrates list-intersect)
  (export list-intersect)
  (import
    (only (scheme base)
          begin
          car
          cdr
          cons
          define
          if
          let
          member
          null?
          quote
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-intersect.scm")))
    (else (include "list-intersect.scm"))))
