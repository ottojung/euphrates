
(define-library
  (euphrates bnf-alist-production-huh)
  (export bnf-alist:production?)
  (import
    (only (euphrates bnf-alist-leaf-huh)
          bnf-alist:leaf?))
  (import
    (only (euphrates list-and-map) list-and-map))
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
          pair?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-production-huh.scm")))
    (else (include "bnf-alist-production-huh.scm"))))
