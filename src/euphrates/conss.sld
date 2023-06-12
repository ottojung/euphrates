
(define-library
  (euphrates conss)
  (export conss)
  (import
    (only (scheme base) begin cond-expand define)
    (only (srfi srfi-1) cons*))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "euphrates/conss.scm")))
    (else (include "conss.scm"))))
