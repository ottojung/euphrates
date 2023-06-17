
(define-library
  (euphrates list-windows)
  (export list-windows)
  (import (only (euphrates list-span) list-span))
  (import
    (only (scheme base)
          append
          begin
          car
          cdr
          cons
          define
          define-values
          if
          let
          let*
          list
          null?
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-windows.scm")))
    (else (include "list-windows.scm"))))
