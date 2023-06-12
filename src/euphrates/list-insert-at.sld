
(define-library
  (euphrates list-insert-at)
  (export list-insert-at)
  (import
    (only (scheme base)
          +
          =
          begin
          car
          cdr
          cons
          define
          if
          let
          null?
          quasiquote
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-insert-at.scm")))
    (else (include "list-insert-at.scm"))))
