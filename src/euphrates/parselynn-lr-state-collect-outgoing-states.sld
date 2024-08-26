
(define-library
  (euphrates
    parselynn-lr-state-collect-outgoing-states)
  (export
    parselynn:lr-state:collect-outgoing-states
    parselynn:lr-state:collect-outgoing-states/given-first)
  (import
    (only (euphrates bnf-alist-compute-first-set)
          bnf-alist:compute-first-set))
  (import
    (only (euphrates hashset) hashset-foreach))
  (import
    (only (euphrates parselynn-lr-goto)
          parselynn:lr-goto/given-first))
  (import
    (only (euphrates parselynn-lr-state-graph)
          parselynn:lr-state-graph:add!))
  (import
    (only (euphrates parselynn-lr-state-next-symbols)
          parselynn:lr-state:next-symbols))
  (import
    (only (scheme base) begin define lambda values))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-state-collect-outgoing-states.scm")))
    (else (include
            "parselynn-lr-state-collect-outgoing-states.scm"))))
