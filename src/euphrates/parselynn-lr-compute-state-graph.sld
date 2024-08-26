
(define-library
  (euphrates parselynn-lr-compute-state-graph)
  (export parselynn:lr-compute-state-graph)
  (import
    (only (euphrates bnf-alist-compute-first-set)
          bnf-alist:compute-first-set))
  (import
    (only (euphrates parselynn-lr-make-initial-state)
          parselynn:lr-make-initial-state/given-first))
  (import
    (only (euphrates
            parselynn-lr-state-collect-outgoing-states)
          parselynn:lr-state:collect-outgoing-states/given-first))
  (import
    (only (euphrates parselynn-lr-state-graph)
          parselynn:lr-state-graph:make))
  (import
    (only (scheme base) begin define for-each let))
  (cond-expand
    (guile (import (only (srfi srfi-31) rec)))
    (else (import (only (srfi 31) rec))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-compute-state-graph.scm")))
    (else (include "parselynn-lr-compute-state-graph.scm"))))
