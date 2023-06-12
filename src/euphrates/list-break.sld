
(define-library
  (euphrates list-break)
  (export list-break)
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
          or
          quote
          reverse
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-break.scm")))
    (else (include "list-break.scm"))))
