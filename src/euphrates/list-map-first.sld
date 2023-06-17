
(define-library
  (euphrates list-map-first)
  (export list-map-first)
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
          or
          quote
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-map-first.scm")))
    (else (include "list-map-first.scm"))))
