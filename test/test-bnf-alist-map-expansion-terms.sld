
(define-library
  (test-bnf-alist-map-expansion-terms)
  (import (only (euphrates assert-equal) assert=))
  (import
    (only (euphrates bnf-alist-map-expansion-terms)
          bnf-alist:map-expansion-terms))
  (import (only (euphrates identity) identity))
  (import (only (scheme base) begin define quote))
  (import (only (scheme inexact) sqrt))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-bnf-alist-map-expansion-terms.scm")))
    (else (include
            "test-bnf-alist-map-expansion-terms.scm"))))
