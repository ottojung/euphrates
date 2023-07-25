(define-library
  (euphrates list-zip-with-longest)
  (export list-zip-with-longest)
  (import (only (euphrates range) range))
  (import
    (only (scheme base)
          *
          +
          -
          <
          begin
          define
          do
          let
          let*
          modulo
          quotient
          vector-ref
          vector-set!))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-zip-with-longest.scm")))
    (else (include "list-zip-with-longest.scm"))))
