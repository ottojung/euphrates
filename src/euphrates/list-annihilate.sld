
(define-library
  (euphrates list-annihilate)
  (export list-annihilate)
  (import
    (only (scheme base)
          +
          -
          <
          begin
          define
          if
          length
          let
          make-vector
          vector->list
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-annihilate.scm")))
    (else (include "list-annihilate.scm"))))
