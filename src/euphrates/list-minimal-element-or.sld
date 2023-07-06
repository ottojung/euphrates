
(define-library
  (euphrates list-minimal-element-or)
  (export list-minimal-element-or)
  (import
    (only (scheme base)
          begin
          car
          cdr
          define
          if
          let
          min
          null?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-minimal-element-or.scm")))
    (else (include "list-minimal-element-or.scm"))))
