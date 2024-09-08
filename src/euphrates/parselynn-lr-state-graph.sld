
(define-library
  (euphrates parselynn-lr-state-graph)
  (export
    parselynn:lr-state-graph:make
    parselynn:lr-state-graph?
    parselynn:lr-state-graph:start
    parselynn:lr-state-graph:add!
    parselynn:lr-state-graph:node-id)
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates hashmap)
          hashmap-count
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates lenode)
          lenode:add-child!
          lenode:make))
  (import
    (only (euphrates olgraph)
          olnode:meta:get-value
          olnode:meta:set-value!
          olnode:value))
  (import
    (only (euphrates parselynn-lr-state)
          parselynn:lr-state:serialize))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (scheme base)
          begin
          define
          let
          list
          not
          or
          quote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-state-graph.scm")))
    (else (include "parselynn-lr-state-graph.scm"))))
