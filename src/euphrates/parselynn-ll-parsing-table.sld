
(define-library
  (euphrates parselynn-ll-parsing-table)
  (export
    parselynn:ll-parsing-table:make
    parselynn:ll-parsing-table?
    parselynn:ll-parsing-table:starting-nonterminal
    parselynn:ll-parsing-table:clauses
    parselynn:ll-parsing-table-clause:make
    parselynn:ll-parsing-table-clause?
    parselynn:ll-parsing-table-clause:production
    parselynn:ll-parsing-table-clause:candidates
    parselynn:ll-parsing-table-clause:actions)
  (import
    (only (euphrates define-type9) define-type9))
  (import (only (euphrates raisu-fmt) raisu-fmt))
  (import
    (only (scheme base)
          begin
          define
          null?
          quote
          when))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-ll-parsing-table.scm")))
    (else (include "parselynn-ll-parsing-table.scm"))))
