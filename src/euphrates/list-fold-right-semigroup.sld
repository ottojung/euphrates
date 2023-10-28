
(define-library
  (euphrates list-fold-right-semigroup)
  (export list-fold/right/semigroup)
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (scheme base)
          begin
          car
          cdr
          cond
          define
          else
          let
          list
          null?
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/list-fold-right-semigroup.scm")))
    (else (include "list-fold-right-semigroup.scm"))))
