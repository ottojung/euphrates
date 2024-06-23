
(define-library
  (euphrates recursive-table-get)
  (export recursive-table:get)
  (import
    (only (euphrates annotated-table-assoc)
          annotated-table-assoc))
  (import
    (only (euphrates define-pair) define-pair))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates recursive-table-self-p)
          recursive-table/self/p))
  (import (only (euphrates stringf) stringf))
  (import
    (only (scheme base)
          begin
          cadr
          car
          cdr
          cons
          define
          equal?
          lambda
          let
          list
          map
          null?
          or
          quote
          when))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/recursive-table-get.scm")))
    (else (include "recursive-table-get.scm"))))
