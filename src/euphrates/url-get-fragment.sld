
(define-library
  (euphrates url-get-fragment)
  (export url-get-fragment)
  (import
    (only (euphrates url-decompose) url-decompose))
  (import
    (only (scheme base) begin define define-values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/url-get-fragment.scm")))
    (else (include "url-get-fragment.scm"))))
