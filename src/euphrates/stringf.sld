
(define-library
  (euphrates stringf)
  (export stringf)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (srfi srfi-28) format)))
    (else (import (only (srfi 28) format))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/stringf.scm")))
    (else (include "stringf.scm"))))
