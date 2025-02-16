
(define-library
  (euphrates
    parselynn-ll-parsing-table-get-conflicts)
  (export parselynn:ll-parsing-table:get-conflicts)
  (import
    (only (euphrates bnf-alist-production-lhs)
          bnf-alist:production:lhs))
  (import (only (euphrates comp) comp))
  (import
    (only (euphrates euphrates-list-sort)
          euphrates:list-sort))
  (import (only (euphrates fn-cons) fn-cons))
  (import
    (only (euphrates hashmap)
          hashmap->alist
          hashmap-ref
          hashmap-set!
          make-hashmap))
  (import
    (only (euphrates hashset) hashset-foreach))
  (import (only (euphrates identity) identity))
  (import
    (only (euphrates list-group-by) list-group-by))
  (import
    (only (euphrates list-map-flatten)
          list-map/flatten))
  (import
    (only (euphrates parselynn-ll-parse-conflict)
          parselynn:ll-parse-first-first-conflict:make))
  (import
    (only (euphrates parselynn-ll-parsing-table)
          parselynn:ll-parsing-table-clause:candidates
          parselynn:ll-parsing-table-clause:production
          parselynn:ll-parsing-table:clauses))
  (import (only (euphrates tilda-s) ~s))
  (import
    (only (scheme base)
          <
          begin
          car
          cdr
          cons
          define
          for-each
          if
          lambda
          length
          map
          null?
          quote
          reverse
          string<?))
  (cond-expand
    (guile (import (only (srfi srfi-1) filter)))
    (else (import (only (srfi 1) filter))))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/parselynn-ll-parsing-table-get-conflicts.scm")))
    (else (include
            "parselynn-ll-parsing-table-get-conflicts.scm"))))
