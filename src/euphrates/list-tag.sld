
(define-library
  (euphrates list-tag)
  (export list-tag list-untag)
  (import
    (only (euphrates list-tag-prev)
          list-tag/prev/rev)
    (only (scheme base)
          and
          append
          begin
          cadr
          car
          cddr
          cdr
          cons
          define
          if
          let
          let*
          not
          null?
          quote
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-tag.scm")))
    (else (include "list-tag.scm"))))
