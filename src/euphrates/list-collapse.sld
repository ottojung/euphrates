
(define-library
  (euphrates list-collapse)
  (export list-collapse)
  (import
    (only (scheme base)
          append
          begin
          car
          cdr
          cond
          cons
          define
          else
          list?
          null?
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-collapse.scm")))
    (else (include "list-collapse.scm"))))
