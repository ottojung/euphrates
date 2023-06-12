
(define-library
  (euphrates cartesian-map)
  (export cartesian-map)
  (import
    (only (scheme base)
          begin
          car
          cdr
          cons
          define
          if
          let
          null?
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/cartesian-map.scm")))
    (else (include "cartesian-map.scm"))))
