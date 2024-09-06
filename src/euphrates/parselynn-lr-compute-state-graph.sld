
(define-library
  (euphrates parselynn-lr-compute-state-graph)
  (export
    parselynn:lr-compute-state-graph
    parselynn:lr-compute-state-graph/given-first)
  (import
    (only (euphrates bnf-alist-compute-first-set)
          bnf-alist:compute-first-set))
  (import
    (only (euphrates bnf-alist-empty-huh)
          bnf-alist:empty?))
  (import
    (only (euphrates bnf-alist-start-symbol)
          bnf-alist:start-symbol))
  (import
    (only (euphrates lenode) lenode:get-child))
  (import
    (only (euphrates parselynn-lr-make-initial-state)
          parselynn:lr-make-initial-state/given-first))
  (import
    (only (euphrates
            parselynn-lr-state-collect-outgoing-states)
          parselynn:lr-state:collect-outgoing-states/given-first))
  (import
    (only (euphrates parselynn-lr-state-graph)
          parselynn:lr-state-graph:add!
          parselynn:lr-state-graph:make
          parselynn:lr-state-graph:start))
  (import
    (only (euphrates parselynn-lr-state)
          parselynn:lr-state:make))
  (import
    (only (scheme base)
          begin
          define
          for-each
          let
          unless))
  (cond-expand
    (guile (import (only (srfi srfi-31) rec)))
    (else (import (only (srfi 31) rec))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-compute-state-graph.scm")))
    (else (include "parselynn-lr-compute-state-graph.scm"))))
