
(define-library
  (euphrates
    parselynn-lr-parsing-table-get-state-conflicts)
  (export
    parselynn:lr-parsing-table:get-state-conflicts)
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates list-singleton-q)
          list-singleton?))
  (import
    (only (euphrates parselynn-lr-parsing-table)
          parselynn:lr-parsing-table:action:list
          parselynn:lr-parsing-table:action:ref))
  (import (only (euphrates raisu-fmt) raisu-fmt))
  (import
    (only (scheme base)
          begin
          cons
          define
          if
          map
          null?
          or
          pair?
          quote
          unless))
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
