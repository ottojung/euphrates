
(define-library
  (euphrates list-zip)
  (export list-zip)
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
             (include-from-path "euphrates/list-zip.scm")))
    (else (include "list-zip.scm"))))
