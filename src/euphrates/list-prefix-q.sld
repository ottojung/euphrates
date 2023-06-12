
(define-library
  (euphrates list-prefix-q)
  (export list-prefix?)
  (import
    (only (scheme base)
          and
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
             (include-from-path "euphrates/list-prefix-q.scm")))
    (else (include "list-prefix-q.scm"))))
