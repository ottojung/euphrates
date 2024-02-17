
(define-library
  (euphrates list-annihilate)
  (export list-annihilate)
  (import
    (only (scheme base)
          _
          and
          begin
          car
          cdr
          cond
          cons
          define
          else
          if
          lambda
          letrec
          map
          not
          null?
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-annihilate.scm")))
    (else (include "list-annihilate.scm"))))
