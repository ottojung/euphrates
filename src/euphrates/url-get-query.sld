
(define-library
  (euphrates url-get-query)
  (export url-get-query)
  (import
    (only (euphrates url-decompose) url-decompose)
    (only (scheme base) begin define define-values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/url-get-query.scm")))
    (else (include "url-get-query.scm"))))
