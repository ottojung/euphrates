
(define-library
  (euphrates group-by-sequential)
  (export group-by/sequential* group-by/sequential)
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
          let*
          list
          null?
          or
          quote
          reverse))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/group-by-sequential.scm")))
    (else (include "group-by-sequential.scm"))))
