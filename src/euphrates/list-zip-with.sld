
(define-library
  (euphrates list-zip-with)
  (export list-zip-with)
  (import
    (only (scheme base)
          begin
          car
          cdr
          cons
          define
          if
          let
          null?
          quote
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-zip-with.scm")))
    (else (include "list-zip-with.scm"))))
