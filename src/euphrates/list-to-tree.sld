
(define-library
  (euphrates list-to-tree)
  (export list->tree)
  (import
    (only (scheme base)
          append
          begin
          car
          case
          cdr
          cons
          define
          else
          if
          let
          let*
          let-values
          null?
          quote
          set!
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-to-tree.scm")))
    (else (include "list-to-tree.scm"))))
