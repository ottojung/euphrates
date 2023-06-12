
(define-library
  (euphrates list-intersperse)
  (export list-intersperse)
  (import
    (only (euphrates conss) conss)
    (only (scheme base)
          begin
          car
          cdr
          define
          if
          let
          null?
          pair?
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-intersperse.scm")))
    (else (include "list-intersperse.scm"))))
