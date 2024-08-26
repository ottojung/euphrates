
(define-library
  (test-parselynn-lr-compute-state-graph)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debug) debug))
  (import
    (only (euphrates parselynn-end-of-input)
          parselynn:end-of-input))
  (import
    (only (euphrates parselynn-lr-compute-state-graph)
          parselynn:lr-compute-state-graph))
  (import
    (only (euphrates parselynn-lr-item)
          parselynn:lr-item:advance
          parselynn:lr-item:make))
  (import
    (only (euphrates
            parselynn-lr-state-collect-outgoing-states)
          parselynn:lr-state:collect-outgoing-states))
  (import
    (only (euphrates parselynn-lr-state-graph)
          parselynn:lr-state-graph:make
          parselynn:lr-state-graph:print))
  (import
    (only (euphrates parselynn-lr-state)
          parselynn:lr-state:add!
          parselynn:lr-state:make))
  (import
    (only (euphrates string-strip) string-strip))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (scheme base)
          +
          _
          begin
          define
          define-syntax
          equal?
          let
          quasiquote
          quote
          string->symbol
          syntax-rules
          unless
          unquote))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-parselynn-lr-compute-state-graph.scm")))
    (else (include
            "test-parselynn-lr-compute-state-graph.scm"))))
