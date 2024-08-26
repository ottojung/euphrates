
(define-library
  (euphrates bnf-alist-to-lr-1-graph)
  (export bnf-alist->lr-1-graph)
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/bnf-alist-to-lr-1-graph.scm")))
    (else (include "bnf-alist-to-lr-1-graph.scm"))))
