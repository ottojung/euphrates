
(define-library
  (euphrates list-find-element-index)
  (export list-find-element-index)
  (import
    (only (scheme base)
          +
          begin
          car
          cdr
          cond
          define
          else
          equal?
          let
          null?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-find-element-index.scm")))
    (else (include "list-find-element-index.scm"))))
