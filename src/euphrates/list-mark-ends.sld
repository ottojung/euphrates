
(define-library
  (euphrates list-mark-ends)
  (export list-mark-ends)
  (import
    (only (scheme base)
          begin
          car
          cdr
          cond
          cons
          define
          else
          list
          null?
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-mark-ends.scm")))
    (else (include "list-mark-ends.scm"))))
