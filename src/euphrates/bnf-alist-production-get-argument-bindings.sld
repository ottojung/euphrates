
(define-library
  (euphrates
    bnf-alist-production-get-argument-bindings)
  (export
    bnf-alist:production:get-argument-bindings)
  (import
    (only (euphrates bnf-alist-production-rhs)
          bnf-alist:production:rhs))
  (import (only (euphrates tilda-a) ~a))
  (import
    (only (scheme base)
          +
          begin
          define
          lambda
          length
          map
          string->symbol
          string-append))
  (cond-expand
    (guile (import (only (srfi srfi-1) iota)))
    (else (import (only (srfi 1) iota))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-production-get-argument-bindings.scm")))
    (else (include
            "bnf-alist-production-get-argument-bindings.scm"))))
