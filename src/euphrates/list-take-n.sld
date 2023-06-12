
(define-library
  (euphrates list-take-n)
  (export list-take-n)
  (import
    (only (scheme base)
          -
          >=
          begin
          car
          cdr
          cons
          define
          if
          let
          null?
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-take-n.scm")))
    (else (include "list-take-n.scm"))))
