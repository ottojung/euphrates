
(define-library
  (euphrates profun-query-get-free-variables)
  (export profun-query-get-free-variables)
  (import
    (only (euphrates profun-varname-q)
          profun-varname?)
    (only (scheme base)
          append
          apply
          begin
          cdr
          define
          map)
    (only (srfi srfi-1) filter))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-query-get-free-variables.scm")))
    (else (include "profun-query-get-free-variables.scm"))))
