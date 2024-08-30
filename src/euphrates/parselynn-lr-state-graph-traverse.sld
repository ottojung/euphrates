
(define-library
  (euphrates parselynn-lr-state-graph-traverse)
  (export parselynn:lr-state-graph:traverse)
  (import (only (euphrates comp) comp))
  (import
    (only (euphrates hashset)
          hashset-add!
          hashset-has?
          make-hashset))
  (import
    (only (euphrates lenode)
          lenode:get-child
          lenode:labels))
  (import (only (euphrates olgraph) olnode:value))
  (import
    (only (euphrates parselynn-lr-state-graph)
          parselynn:lr-state-graph:node-id
          parselynn:lr-state-graph:start))
  (import
    (only (scheme base)
          begin
          define
          for-each
          let
          list
          map
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-state-graph-traverse.scm")))
    (else (include "parselynn-lr-state-graph-traverse.scm"))))
