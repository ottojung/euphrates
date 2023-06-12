
(define-library
  (euphrates cartesian-any-q)
  (export cartesian-any?)
  (import
    (only (scheme base)
          begin
          car
          cdr
          define
          if
          let
          null?
          or))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/cartesian-any-q.scm")))
    (else (include "cartesian-any-q.scm"))))
