
(define-library
  (euphrates list-and-map)
  (export list-and-map)
  (import
    (only (scheme base)
          begin
          car
          cdr
          define
          if
          let
          null?))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-and-map.scm")))
    (else (include "list-and-map.scm"))))
