
(define-library
  (euphrates recursive-table)
  (export recursive-table)
  (import (only (euphrates memconst) memconst))
  (import
    (only (euphrates recursive-table-self-p)
          recursive-table/self/p))
  (import
    (only (scheme base)
          +
          _
          begin
          cons
          define
          define-syntax
          lambda
          let
          list
          map
          parameterize
          reverse
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path
               "euphrates/recursive-table.scm")))
    (else (include "recursive-table.scm"))))
