
(define-library
  (euphrates
    parselynn-lr-parsing-table-get-conflicts)
  (export parselynn:lr-parsing-table:get-conflicts)
  (import
    (only (euphrates list-map-flatten)
          list-map/flatten))
  (import
    (only (euphrates
            parselynn-lr-parsing-table-get-state-conflicts)
          parselynn:lr-parsing-table:get-state-conflicts))
  (import
    (only (euphrates parselynn-lr-parsing-table)
          parselynn:lr-parsing-table:state:keys))
  (import (only (scheme base) begin define))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-lr-parsing-table-get-conflicts.scm")))
    (else (include
            "parselynn-lr-parsing-table-get-conflicts.scm"))))
