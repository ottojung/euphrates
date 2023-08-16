
(define-library
  (euphrates lalr-lexr-latin-tokens)
  (export lalr-lexr/latin-tokens)
  (import
    (only (scheme base) <= begin define list quote))
  (cond-expand
    (guile (import (only (srfi srfi-67) <?)))
    (else (import (only (srfi 67) <?))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/lalr-lexr-latin-tokens.scm")))
    (else (include "lalr-lexr-latin-tokens.scm"))))
