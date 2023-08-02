
(define-library
  (euphrates list-zip-with-longest)
  (export list-zip-with-longest)
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
               "euphrates/list-zip-with-longest.scm")))
    (else (include "list-zip-with-longest.scm"))))
