
(define-library
  (euphrates parselynn-lr-state-graph)
  (export
    parselynn:lr-state-graph:make
    parselynn:lr-state-graph?
    parselynn:lr-state-graph:start
    parselynn:lr-state-graph:add!
    parselynn:lr-state-graph:node-id
    parselynn:lr-state-graph:print)
  (import (only (euphrates comp) comp))
  (import
    (only (euphrates define-type9) define-type9))
  (import
    (only (euphrates hashmap)
          hashmap-count
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates hashset)
          hashset-add!
          hashset-has?
          make-hashset))
  (import
    (only (euphrates lenode)
          lenode:add-child!
          lenode:get-child
          lenode:labels
          lenode:make))
  (import
    (only (euphrates object-to-string)
          object->string))
  (import
    (only (euphrates olgraph)
          olnode:meta:get-value
          olnode:meta:set-value!
          olnode:value))
  (import
    (only (euphrates parselynn-lr-state)
          parselynn:lr-state:print))
  (import (only (euphrates raisu-star) raisu*))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (scheme base)
          begin
          current-output-port
          define
          for-each
          let
          list
          map
          newline
          not
          or
          parameterize
          quote
          unless
          values))
  (import (only (scheme case-lambda) case-lambda))
  (import (only (scheme write) display))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-state-graph.scm")))
    (else (include "parselynn-lr-state-graph.scm"))))
