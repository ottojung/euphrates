
(define-library
  (euphrates list-length-geq-q)
  (export list-length=<?)
  (import
    (only (scheme base)
          -
          <=
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
               "euphrates/list-length-geq-q.scm")))
    (else (include "list-length-geq-q.scm"))))
