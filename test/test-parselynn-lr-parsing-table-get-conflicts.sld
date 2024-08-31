
(define-library
  (test-parselynn-lr-parsing-table-get-conflicts)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debug) debug))
  (import
    (only (euphrates parselynn-lr-compute-parsing-table)
          parselynn:lr-compute-parsing-table))
  (import
    (only (euphrates
            parselynn-lr-parsing-table-get-conflicts)
          parselynn:lr-parsing-table:get-conflicts))
  (import
    (only (scheme base)
          /
          _
          begin
          define
          define-syntax
          equal?
          let
          quasiquote
          quote
          syntax-rules
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-parselynn-lr-parsing-table-get-conflicts.scm")))
    (else (include
            "test-parselynn-lr-parsing-table-get-conflicts.scm"))))
