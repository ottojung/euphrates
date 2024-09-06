
(define-library
  (euphrates bnf-alist-add-production)
  (export bnf-alist:add-production)
  (import
    (only (euphrates bnf-alist-production-lhs)
          bnf-alist:production:lhs))
  (import
    (only (euphrates bnf-alist-production-rhs)
          bnf-alist:production:rhs))
  (import
    (only (scheme base)
          append
          begin
          car
          cdr
          cons
          define
          equal?
          if
          let
          list
          null?))
  (cond-expand
    (guile (import (only (srfi srfi-1) first)))
    (else (import (only (srfi 1) first))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-add-production.scm")))
    (else (include "bnf-alist-add-production.scm"))))
