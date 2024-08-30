
(define-library
  (euphrates parselynn-lr-compute-parsing-table)
  (export
    parselynn:lr-compute-parsing-table
    parselynn:lr-compute-parsing-table/given-first)
  (import
    (only (euphrates bnf-alist-compute-first-set)
          bnf-alist:compute-first-set))
  (import
    (only (euphrates parselynn-lr-compute-state-graph)
          parselynn:lr-compute-state-graph/given-first))
  (import
    (only (euphrates
            parselynn-lr-state-graph-to-lr-parsing-table)
          parselynn:lr-state-graph->lr-parsing-table))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-compute-parsing-table.scm")))
    (else (include
            "parselynn-lr-compute-parsing-table.scm"))))
