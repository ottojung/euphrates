
(define-library
  (euphrates bnf-alist-production-huh)
  (export bnf-alist:production?)
  (import
    (only (scheme base)
          and
          begin
          cadr
          car
          cdr
          define
          list?
          null?
          pair?
          symbol?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-production-huh.scm")))
    (else (include "bnf-alist-production-huh.scm"))))
