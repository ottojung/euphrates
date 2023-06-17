
(define-library
  (euphrates list-find-first)
  (export list-find-first)
  (import (only (euphrates raisu) raisu))
  (import
    (only (scheme base)
          _
          begin
          car
          cdr
          define-syntax
          if
          let
          null?
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-find-first.scm")))
    (else (include "list-find-first.scm"))))
