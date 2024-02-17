
(define-library
  (euphrates list-annihilate)
  (export list-annihilate)
  (import
    (only (euphrates list-or-map) list-or-map))
  (import
    (only (scheme base)
          begin
          car
          cdr
          cond
          cons
          define
          else
          if
          lambda
          let
          map
          null?
          quote
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-annihilate.scm")))
    (else (include "list-annihilate.scm"))))
