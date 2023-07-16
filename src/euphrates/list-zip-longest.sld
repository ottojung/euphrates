
(define-library
  (euphrates list-zip-longest)
  (export list-zip-longest)
  (import
    (only (scheme base)
          and
          begin
          car
          cdr
          cons
          define
          if
          let
          list
          null?
          quote
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-zip-longest.scm")))
    (else (include "list-zip-longest.scm"))))
