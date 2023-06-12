
(define-library
  (euphrates list-drop-while)
  (export list-drop-while)
  (import
    (only (scheme base)
          begin
          car
          cdr
          define
          if
          let
          null?
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-drop-while.scm")))
    (else (include "list-drop-while.scm"))))
