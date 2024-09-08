
(define-library
  (test-parselynn-lr-compute-state-graph)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debug) debug))
  (import
    (only (euphrates parselynn-lr-compute-state-graph)
          parselynn:lr-compute-state-graph))
  (import
    (only (euphrates parselynn-lr-state-graph-print)
          parselynn:lr-state-graph:print))
  (import
    (only (euphrates string-strip) string-strip))
  (import
    (only (euphrates with-output-stringified)
          with-output-stringified))
  (import
    (only (scheme base)
          _
          begin
          define
          define-syntax
          equal?
          let
          quasiquote
          syntax-rules
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-parselynn-lr-compute-state-graph.scm")))
    (else (include
            "test-parselynn-lr-compute-state-graph.scm"))))
