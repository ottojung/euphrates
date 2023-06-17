
(define-library
  (euphrates conss)
  (export conss)
  (import
    (only (scheme base)
          begin
          car
          cdr
          cond-expand
          cons
          define
          else
          if
          let
          null?))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (import (only (guile) cons*))
           (begin (define conss cons*)))
    (else (include "conss.scm"))))
