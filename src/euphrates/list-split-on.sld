
(define-library
  (euphrates list-split-on)
  (export list-split-on)
  (import
    (only (scheme base)
          begin
          car
          cdr
          cond
          cons
          define
          else
          if
          let
          not
          null?
          or
          quote
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-split-on.scm")))
    (else (include "list-split-on.scm"))))
