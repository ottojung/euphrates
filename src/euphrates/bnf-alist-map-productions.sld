
(define-library
  (euphrates bnf-alist-map-productions)
  (export bnf-alist:map-productions)
  (import
    (only (euphrates bnf-alist-map-grouped-productions)
          bnf-alist:map-grouped-productions))
  (import (only (euphrates comp) comp))
  (import (only (scheme base) begin define map))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-map-productions.scm")))
    (else (include "bnf-alist-map-productions.scm"))))
