
(define-library
  (euphrates list-tag-prev)
  (export list-tag/prev list-tag/prev/rev)
  (import
    (only (scheme base)
          begin
          car
          cdr
          cond
          cons
          define
          else
          let
          null?
          quote
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-tag-prev.scm")))
    (else (include "list-tag-prev.scm"))))
