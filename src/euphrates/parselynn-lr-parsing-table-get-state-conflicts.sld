
(define-library
  (euphrates
    parselynn-lr-parsing-table-get-state-conflicts)
  (export
    parselynn:lr-parsing-table:get-state-conflicts)
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates parselynn-lr-parse-conflict)
          parselynn:lr-parse-conflict?))
  (import
    (only (euphrates parselynn-lr-parsing-table)
          parselynn:lr-parsing-table:action:list
          parselynn:lr-parsing-table:action:ref))
  (import
    (only (scheme base) and begin define map))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-parsing-table-get-state-conflicts.scm")))
    (else (include
            "parselynn-lr-parsing-table-get-state-conflicts.scm"))))
