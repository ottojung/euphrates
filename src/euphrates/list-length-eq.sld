
(define-library
  (euphrates list-length-eq)
  (export list-length=)
  (import
    (only (scheme base)
          -
          <=
          =
          and
          begin
          cdr
          define
          if
          let
          null?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-length-eq.scm")))
    (else (include "list-length-eq.scm"))))
