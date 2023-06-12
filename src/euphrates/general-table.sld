
(define-library
  (euphrates general-table)
  (export general-table)
  (import
    (only (scheme base)
          +
          _
          begin
          cons
          define-syntax
          list
          reverse
          syntax-rules))
  (cond-expand
    (guile (import (only (guile) include-from-path))
           (begin
             (include-from-path "euphrates/general-table.scm")))
    (else (include "general-table.scm"))))
