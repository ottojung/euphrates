
(define-library
  (euphrates bnf-alist-assoc-productions)
  (export bnf-alist:assoc-productions)
  (import (only (euphrates assoc-or) assoc-or))
  (import
    (only (scheme base)
          _
          begin
          define-syntax
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-assoc-productions.scm")))
    (else (include "bnf-alist-assoc-productions.scm"))))
