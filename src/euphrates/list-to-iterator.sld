
(define-library
  (euphrates list-to-iterator)
  (export list->iterator)
  (import
    (only (euphrates iterator) iterator:make))
  (import
    (only (scheme base)
          begin
          car
          cdr
          define
          if
          let
          null?
          set!
          values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-to-iterator.scm")))
    (else (include "list-to-iterator.scm"))))
