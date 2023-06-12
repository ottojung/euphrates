
(define-library
  (euphrates profun-varname-q)
  (export profun-varname?)
  (import
    (only (euphrates usymbol) usymbol?)
    (only (scheme base) begin define or symbol?))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/profun-varname-q.scm")))
    (else (include "profun-varname-q.scm"))))
