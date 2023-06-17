
(define-library
  (euphrates raisu)
  (export raisu)
  (import
    (only (scheme base)
          apply
          begin
          cond-expand
          cons
          define
          else
          raise))
  (cond-expand
    (guile (import (only (guile) include-from-path throw))
           (begin (include-from-path "euphrates/raisu.scm")))
    (else (include "raisu.scm"))))
