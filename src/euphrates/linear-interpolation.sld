
(define-library
  (euphrates linear-interpolation)
  (export
    linear-interpolate-1d
    linear-interpolate-2d)
  (import
    (only (euphrates raisu) raisu)
    (only (scheme base)
          *
          +
          -
          <=
          and
          begin
          car
          cdr
          cons
          define
          number?
          quote
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/linear-interpolation.scm")))
    (else (include "linear-interpolation.scm"))))
