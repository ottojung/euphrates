
(define-library
  (euphrates list-tag-next)
  (export
    list-tag/next
    list-tag/next/rev
    list-untag/next)
  (import
    (only (scheme base)
          and
          append
          apply
          begin
          car
          cdr
          cond
          cons
          define
          else
          if
          let
          null?
          quote
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-tag-next.scm")))
    (else (include "list-tag-next.scm"))))
