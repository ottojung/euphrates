
(define-library
  (euphrates list-minimal-element-or-proj)
  (export list-minimal-element-or/proj)
  (import
    (only (scheme base)
          begin
          car
          cdr
          cond
          define
          else
          if
          let
          let*
          min
          null?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-minimal-element-or-proj.scm")))
    (else (include "list-minimal-element-or-proj.scm"))))
