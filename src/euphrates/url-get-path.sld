
(define-library
  (euphrates url-get-path)
  (export url-get-path)
  (import
    (only (euphrates url-decompose) url-decompose)
    (only (scheme base) begin define define-values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/url-get-path.scm")))
    (else (include "url-get-path.scm"))))
