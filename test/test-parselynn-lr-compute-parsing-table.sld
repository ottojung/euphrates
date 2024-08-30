
(define-library
  (test-parselynn-lr-compute-parsing-table)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debug) debug))
  (import
    (only (euphrates parselynn-lr-compute-parsing-table)
          parselynn:lr-compute-parsing-table))
  (import
    (only (euphrates parselynn-lr-parsing-table-print)
          parselynn:lr-parsing-table:print))
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
          quote
          syntax-rules
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-parselynn-lr-compute-parsing-table.scm")))
    (else (include
            "test-parselynn-lr-compute-parsing-table.scm"))))
