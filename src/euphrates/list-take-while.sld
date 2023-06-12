
(define-library
  (euphrates list-take-while)
  (export list-take-while)
  (import
    (only (scheme base)
          begin
          car
          cdr
          cons
          define
          if
          let
          null?
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-take-while.scm")))
    (else (include "list-take-while.scm"))))
