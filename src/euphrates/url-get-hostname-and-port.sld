
(define-library
  (euphrates url-get-hostname-and-port)
  (export url-get-hostname-and-port)
  (import
    (only (euphrates url-decompose) url-decompose)
    (only (scheme base) begin define define-values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/url-get-hostname-and-port.scm")))
    (else (include "url-get-hostname-and-port.scm"))))
