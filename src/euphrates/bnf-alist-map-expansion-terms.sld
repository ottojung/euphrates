
(define-library
  (euphrates bnf-alist-map-expansion-terms)
  (export bnf-alist:map-expansion-terms)
  (import (only (euphrates fn-cons) fn-cons))
  (import (only (euphrates identity) identity))
  (import (only (scheme base) begin define map))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-map-expansion-terms.scm")))
    (else (include "bnf-alist-map-expansion-terms.scm"))))
