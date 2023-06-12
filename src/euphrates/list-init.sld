
(define-library
  (euphrates list-init)
  (export list-init)
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
             (include-from-path "euphrates/list-init.scm")))
    (else (include "list-init.scm"))))
