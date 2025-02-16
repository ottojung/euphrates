
(define-library
  (test-parselynn-ll-parsing-table-get-conflicts)
  (import (only (euphrates assert-equal) assert=))
  (import (only (euphrates debug) debug))
  (import
    (only (euphrates parselynn-ll-compute-parsing-table)
          parselynn:ll-compute-parsing-table))
  (import
    (only (euphrates parselynn-ll-parse-conflict-print)
          parselynn:ll-parse-conflict:print))
  (import
    (only (euphrates
            parselynn-ll-parsing-table-get-conflicts)
          parselynn:ll-parsing-table:get-conflicts))
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
          map
          quasiquote
          quote
          syntax-rules
          unless))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "test-parselynn-ll-parsing-table-get-conflicts.scm")))
    (else (include
            "test-parselynn-ll-parsing-table-get-conflicts.scm"))))
