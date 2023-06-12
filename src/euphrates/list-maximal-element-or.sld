
(define-library
  (euphrates list-maximal-element-or)
  (export list-maximal-element-or)
  (import
    (only (scheme base)
          >
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
               "euphrates/list-maximal-element-or.scm")))
    (else (include "list-maximal-element-or.scm"))))
