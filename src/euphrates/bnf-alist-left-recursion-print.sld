
(define-library
  (euphrates bnf-alist-left-recursion-print)
  (export bnf-alist:left-recursion:print)
  (import
    (only (euphrates bnf-alist-left-recursion)
          bnf-alist:left-recursion:cycle
          bnf-alist:left-recursion:nonterminal))
  (import (only (euphrates fprintf) fprintf))
  (import (only (euphrates tilda-a) ~a))
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
               "euphrates/bnf-alist-left-recursion-print.scm")))
    (else (include "bnf-alist-left-recursion-print.scm"))))
