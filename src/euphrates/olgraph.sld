
(define-library
  (euphrates olgraph)
  (export olgraph)
  (import
    (only (scheme base) begin define-record-type))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/olgraph.scm")))
    (else (include "olgraph.scm"))))
