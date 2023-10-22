
(define-library
  (euphrates list-fold-semigroup)
  (export list-fold/semigroup)
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (scheme base)
          begin
          car
          cdr
          cond
          define
          else
          if
          let
          list
          null?
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-fold-semigroup.scm")))
    (else (include "list-fold-semigroup.scm"))))
