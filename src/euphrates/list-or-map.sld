
(define-library
  (euphrates list-or-map)
  (export list-or-map)
  (import
    (only (scheme base)
          begin
          car
          cdr
          define
          if
          let
          null?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/list-or-map.scm")))
    (else (include "list-or-map.scm"))))
