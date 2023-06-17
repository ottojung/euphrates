
(define-library
  (euphrates conss)
  (export conss)
  (import
    (only (scheme base) begin cond-expand define))
  (cond-expand
    (guile (import (only (srfi srfi-1) cons*)))
    (else (import (only (srfi 1) cons*))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin (include-from-path "euphrates/conss.scm")))
    (else (include "conss.scm"))))
