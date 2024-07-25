
(define-library
  (euphrates bnf-alist-for-each-production)
  (export bnf-alist:for-each-production)
  (import
    (only (scheme base)
          begin
          car
          cdr
          define
          for-each
          lambda
          map))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-for-each-production.scm")))
    (else (include "bnf-alist-for-each-production.scm"))))
