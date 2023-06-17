
(define-library
  (euphrates profun-query-get-free-variables)
  (export profun-query-get-free-variables)
  (import
    (only (euphrates profun-varname-q)
          profun-varname?))
  (import
    (only (scheme base)
          append
          apply
          begin
          cdr
          define
          map))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-query-get-free-variables.scm")))
    (else (include "profun-query-get-free-variables.scm"))))
