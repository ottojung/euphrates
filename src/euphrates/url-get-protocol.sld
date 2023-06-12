
(define-library
  (euphrates url-get-protocol)
  (export url-get-protocol)
  (import
    (only (euphrates url-decompose) url-decompose)
    (only (scheme base) begin define define-values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/url-get-protocol.scm")))
    (else (include "url-get-protocol.scm"))))
