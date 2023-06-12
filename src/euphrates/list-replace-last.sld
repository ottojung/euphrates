
(define-library
  (euphrates list-replace-last)
  (export list-replace-last-element)
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
          quote
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-replace-last.scm")))
    (else (include "list-replace-last.scm"))))
