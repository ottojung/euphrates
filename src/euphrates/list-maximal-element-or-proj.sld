
(define-library
  (euphrates list-maximal-element-or-proj)
  (export list-maximal-element-or/proj)
  (import
    (only (scheme base)
          begin
          car
          cdr
          define
          if
          let
          let*
          max
          null?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-maximal-element-or-proj.scm")))
    (else (include "list-maximal-element-or-proj.scm"))))
