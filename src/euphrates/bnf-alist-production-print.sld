
(define-library
  (euphrates bnf-alist-production-print)
  (export bnf-alist:production:print)
  (import
    (only (euphrates bnf-alist-production-lhs)
          bnf-alist:production:lhs))
  (import
    (only (euphrates bnf-alist-production-rhs)
          bnf-alist:production:rhs))
  (import (only (euphrates fprintf) fprintf))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (euphrates words-to-string) words->string))
  (import
    (only (scheme base)
          begin
          current-output-port
          define
          map))
  (import (only (scheme case-lambda) case-lambda))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-production-print.scm")))
    (else (include "bnf-alist-production-print.scm"))))
