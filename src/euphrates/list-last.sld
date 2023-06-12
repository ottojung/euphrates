
(define-library
  (euphrates list-last)
  (export list-last)
  (import
    (only (scheme base)
          begin
          car
          cdr
          define
          if
          let
          null?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-last.scm")))
    (else (include "list-last.scm"))))
